import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';

import '../controller/new_task_controller.dart';
import '../utility/app_colors.dart';
import '../widget/center_progress_indicator.dart';
import '../widget/task_item.dart';
import '../widget/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    Get.find<NewTaskController>().getTaskStatusCount();
    Get.find<NewTaskController>().getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<NewTaskController>(
            builder: (controller) {
              return _buildSummarySection(controller);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProgress == false,
                    replacement: const CenterProgressIndicator(),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _initializeData();
                      },
                      child: ListView.builder(
                        itemCount: newTaskController.newTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskItem(
                            taskModel: newTaskController.newTaskList[index],
                            onUpdateTask: _initializeData,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddButton() async {
    bool? taskAdded = await Get.toNamed(addNewTask);

    // If a new task was added, refresh the task list
    if (taskAdded == true) {
      _initializeData();
    }
  }

  Widget _buildSummarySection(NewTaskController newTaskController) {
    return Visibility(
      visible: newTaskController.getTaskCountStatusInProgress == false,
      replacement:
          const SizedBox(height: 100, child: CenterProgressIndicator()),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: newTaskController.taskCountByStatusModel
              .map((e) => TaskSummaryCard(
                    title: (e.sId ?? 'Unknown').toUpperCase(),
                    count: e.sum?.toString() ?? '0',
                  ))
              .toList(),
        ),
      ),
    );
  }
}
