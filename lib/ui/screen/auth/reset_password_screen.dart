import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/sign_in_screen.dart';

import '../../../data/model/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
import '../../utility/app_colors.dart';
import '../../widget/background_widget.dart';
import '../../widget/center_progress_indicator.dart';
import '../../widget/snackbar_message.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email, required this.otp});
  final String email,otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  bool _setPasswordInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Minimum length of password should be more than 6 letters and combination number',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Password')),
                TextFormField(
                    controller: _confirmPasswordTEController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Confirm Password')),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _setPasswordInProgress==false,
                  replacement: const CenterProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapConfirmButton,
                    child: const Text('Confirm'),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4),
                        text: "Have account? ",
                        children: [
                          TextSpan(
                            style: const TextStyle(color: AppColors.themeColor),
                            text: "Sign in",
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _resetPassword(String password) async {
    _setPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String,dynamic> inputParams=  {
      "email":widget.email,
      "OTP":widget.otp,
      "password":password,
    };

    NetworkResponse response =
    await NetworkCaller.postRequest(Urls.resetPassword,body: inputParams);
    _setPasswordInProgress = false;
    if(mounted){
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        showSnackbarMessage(context,'Password reset successful! Try logging in now.');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
                (route) => false);
      }
    } else {
      if (mounted) {
        showSnackbarMessage(context,
            response.errorMessage ?? 'Reset Password Failed! Try Again');
      }
    }
  }


  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }

  void _onTapConfirmButton() {
    _resetPassword(_passwordTEController.text);
  }

}
