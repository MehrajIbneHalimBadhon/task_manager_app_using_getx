import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/controller/in_progress_task_controller.dart';

import '../widget/center_progress_indicator.dart';
import '../widget/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({
    super.key,
  });

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  void _getProgressTask() async {
    Get.find<InProgressTaskController>().getProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InProgressTaskController>(
          builder: (inProgressTaskController) {
        return Visibility(
          visible: inProgressTaskController.getTaskInProgress == false,
          replacement: const CenterProgressIndicator(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: inProgressTaskController.taskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: inProgressTaskController.taskList[index],
                      onUpdateTask: _getProgressTask);

                  // return const TaskItem();
                }),
          ),
        );
      }),
    );
  }
}
