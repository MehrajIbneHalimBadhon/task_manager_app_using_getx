import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/controller/completed_task_controller.dart';

import '../widget/center_progress_indicator.dart';
import '../widget/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({
    super.key,
  });

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {


  @override
  void initState() {
    _getCompletedTask();
    super.initState();
  }

  void _getCompletedTask() {
    Get.find<CompletedTaskController>().getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompletedTaskController>(
          builder: (completeTaskController) {
        return Visibility(
          visible: completeTaskController.getcompletedTaskInProgress == false,
          replacement: const CenterProgressIndicator(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: completeTaskController.completedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: completeTaskController.completedTaskList[index],
                    onUpdateTask: () {
                      _getCompletedTask();
                    },
                  );
                  // return const TaskItem();
                }),
          ),
        );
      }),
    );
  }
}
