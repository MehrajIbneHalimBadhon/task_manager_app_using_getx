import 'package:flutter/material.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widget/center_progress_indicator.dart';
import '../widget/snackbar_message.dart';
import '../widget/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key,});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getTaskInProgress = false;
  List<TaskModel> _taskList=[];
  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getTaskInProgress == false,
        replacement: const CenterProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                return TaskItem(taskModel: _taskList[index], onUpdateTask: (){
                  _getProgressTask();
                });

                // return const TaskItem();
              }),
        ),
      ),
    );
  }
  Future<void> _getProgressTask() async {
    _getTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseDate);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackbarMessage(
            context, response.errorMessage ?? 'Get Progress Task Failed! Try Again');
      }
    }

    _getTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
