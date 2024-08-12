import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CompletedTaskController extends GetxController{
  bool _getCompletedTaskInProgress = false;
  bool get getcompletedTaskInProgress =>_getCompletedTaskInProgress;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  List<TaskModel> _completedTaskList = [];
  List<TaskModel> get completedTaskList =>_completedTaskList;

  Future<void> getCompletedTask() async {
    _getCompletedTaskInProgress = true;
    update();
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseDate);
      _completedTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage = 'Get completed tasks failed! Try again';
    }
    _getCompletedTaskInProgress = false;
   update();
  }

}