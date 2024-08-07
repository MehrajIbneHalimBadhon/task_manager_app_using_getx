import 'package:flutter/material.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widget/center_progress_indicator.dart';
import '../widget/snackbar_message.dart';
import '../widget/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key, });

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;

  List<TaskModel> _completedTaskList = [];
  @override
  void initState() {
    _getCompletedTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCompletedTaskInProgress == false,
        replacement: const CenterProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: _completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskItem(taskModel: _completedTaskList[index], onUpdateTask: () {
                  _getCompletedTask();
                },);
                // return const TaskItem();
              }),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async {
    _getCompletedTaskInProgress = true;
    if (mounted) setState(() {});
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseDate);
      _completedTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackbarMessage(context,
            response.errorMessage ?? 'Get Completed Task Failed! Try Again');
      }
    }
    _getCompletedTaskInProgress = false;
    if (mounted) setState(() {});
  }
}
