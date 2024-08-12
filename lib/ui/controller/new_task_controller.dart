import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_by_status_count_wrapper_mode.dart';
import '../../data/model/task_count_by_status_model.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool _getTaskCountStatusInProgress = false;

  bool get getTaskCountStatusInProgress => _getTaskCountStatusInProgress;
  List<TaskModel> _taskList = [];

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  String _errorMessage = '';

  List<TaskModel> get newTaskList => _taskList;

  String get errorMessage => _errorMessage;
  List<TaskCountByStatusModel> _taskCountByStatusModel = [];

  List<TaskCountByStatusModel> get taskCountByStatusModel =>
      _taskCountByStatusModel;

  Future<bool> getNewTask() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseDate);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage = response.errorMessage ?? 'Get New Task Failed! Try Again';
    }

    _getNewTaskInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _getTaskCountStatusInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseDate);
      _taskCountByStatusModel =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = 'Get Task Status Count Failed! Try Again';
    }

    _getTaskCountStatusInProgress = false;
    update();
    return isSuccess;
  }
}
