import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'package:get/get.dart';


class ResetPasswordController extends GetxController{
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  bool _setPasswordInProgress = false;
  bool get setPasswordInProgress => _setPasswordInProgress;
  Future<bool> resetPassword(String email,String otp,String password) async {
    bool isSuccess = false;

    _setPasswordInProgress = true;
    update();

    Map<String,dynamic> inputParams=  {
      "email":email,
      "OTP":otp,
      "password":password,
    };

    NetworkResponse response =
    await NetworkCaller.postRequest(Urls.resetPassword,body: inputParams);
    _setPasswordInProgress = false;
    update();

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Reset Password Failed! Try Again';
    }
    _setPasswordInProgress = false;
    update();
    return isSuccess;
  }

}