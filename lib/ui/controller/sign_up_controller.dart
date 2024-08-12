import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class SignUpController extends GetxController {
  bool _registrationInProgress = false;

  bool get registrationInProgress => _registrationInProgress;
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> registerUser(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _registrationInProgress = true;
    update();
    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, body: requestInput);
    _registrationInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Registration failed! Try again';
    }
    return isSuccess;
  }
}
