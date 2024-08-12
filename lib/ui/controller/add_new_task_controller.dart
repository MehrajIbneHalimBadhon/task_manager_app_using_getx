import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;
  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String _errorMessage = "";
  String  get errorMessage => _errorMessage;
  Future<bool> addNewTask(String title,String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "New"
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestData,
    );
    _addNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      }
     else {
      _errorMessage ='New task add failed! Try again';
    }
     update();
     return isSuccess;
  }

}