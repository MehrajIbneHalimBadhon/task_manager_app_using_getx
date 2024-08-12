import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../screen/auth/reset_password_screen.dart';

class PinVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  String _errorMessage = '';

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  String get errorMessage => _errorMessage;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyOtp(email, otp));

    _otpVerificationInProgress = false;
    update();

    if (response.isSuccess && response.responseDate?['status'] == 'success') {
      Get.to(() => ResetPasswordScreen(
          email: email, otp: otp));
      return true;
    } else {
      _errorMessage =
          response.errorMessage ?? 'OTP Verification Failed! Try Again';
      return false;
    }
  }
}
