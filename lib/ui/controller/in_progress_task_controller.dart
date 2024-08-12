import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class InProgressTaskController extends GetxController{
  bool _getTaskInProgress = false;
  bool get getTaskInProgress => _getTaskInProgress;
  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => _taskList;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  Future<bool> getProgressTask() async {
    bool isSuccess = false;
    _getTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseDate);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage = 'Get Progress Task Failed! Try Again';
    }

    _getTaskInProgress = false;
    update();
    return isSuccess;
  }

}