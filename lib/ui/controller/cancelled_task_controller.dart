import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/data/model/task_model.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CancelledTaskController extends GetxController{
  bool _getTaskCancel = false;
  bool get getTaskCancel => _getTaskCancel;
  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => _taskList;
  String _errorMessage ='';
  String get errorMessage => _errorMessage;
Future<bool> getCancelTask() async {
    bool isSuccess = false;
    _getTaskCancel = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseDate);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage = 'Get cancelled tasks failed! Try again';
    }

    _getTaskCancel = false;
    update();
    return isSuccess;
  }

}