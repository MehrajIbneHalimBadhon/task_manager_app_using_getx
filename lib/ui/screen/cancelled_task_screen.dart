import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/widget/center_progress_indicator.dart';
import 'package:task_manager_app_using_getx/ui/widget/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({
    super.key,
  });

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    _getCancelTask();
    super.initState();
  }

  void _getCancelTask() {
    Get.find<CancelledTaskController>().getCancelTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CancelledTaskController>(
          builder: (cancelledTaskController) {
        return Visibility(
          visible: cancelledTaskController.getTaskCancel == false,
          replacement: const CenterProgressIndicator(),
          child: ListView.builder(
              itemCount: cancelledTaskController.taskList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                    taskModel: cancelledTaskController.taskList[index],
                    onUpdateTask: _getCancelTask);

                // return const TaskItem();
              }),
        );
      }),
    );
  }
}
