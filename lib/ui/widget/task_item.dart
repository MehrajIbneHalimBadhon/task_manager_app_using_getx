import 'package:flutter/material.dart';
import 'package:task_manager_app_using_getx/ui/widget/snackbar_message.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../utility/app_colors.dart';
import 'center_progress_indicator.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  String dropdownValue = '';
  List<String> statusList = ['New', 'Progress', 'Completed', 'Cancelled'];

  @override
  void initState() {
    dropdownValue = widget.taskModel.status!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(
              'Date: ${widget.taskModel.createdDate}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status ?? 'New',
                    style: const TextStyle(color: Colors.black),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  backgroundColor: AppColors.white,
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: _editInProgress == false,
                      replacement: const CenterProgressIndicator(),
                      child: _buildEditButton(),
                    ),
                    Visibility(
                        visible: _deleteInProgress == false,
                        replacement: const CenterProgressIndicator(),
                        child: IconButton(
                          onPressed: () {
                            _deleteTask();
                          },
                          icon: const Icon(Icons.delete_outlined),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return PopupMenuButton(
        icon: const Icon(Icons.edit),
        onSelected: (String selectedValue) {
          dropdownValue = selectedValue;
          _updateTask(dropdownValue);
        },
        itemBuilder: (BuildContext context) {
          return statusList.map((String value) {
            return PopupMenuItem(
              value: value,
              child: ListTile(
                title: Text(value),
                trailing:
                    dropdownValue == value ? const Icon(Icons.done) : null,
              ),
            );
          }).toList();
        });
  }

  Future<void> _updateTask(String status) async {
    _editInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(status,widget.taskModel.sId!));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackbarMessage(context,
            response.errorMessage ?? 'Update Task Status Failed! Try Again');
      }
    }

    _editInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteTask() async {
    _deleteInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackbarMessage(
            context,
            response.errorMessage ??
                'Get Task Count by Status Failed! Try Again');
      }
    }

    _deleteInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
