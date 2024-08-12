import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class EmailVerificationController extends GetxController{
  bool _emailVerificationInProgress = false;
  bool get emailVerificationInProgress => _emailVerificationInProgress;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _emailVerificationInProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.verifyEmail(email));
    _emailVerificationInProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = 'Email verification failed! Try again';
    }
    return isSuccess;
  }

}