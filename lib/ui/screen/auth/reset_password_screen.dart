import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';

import '../../controller/reset_password_controller.dart';
import '../../utility/app_colors.dart';
import '../../widget/background_widget.dart';
import '../../widget/center_progress_indicator.dart';
import '../../widget/snackbar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.email, required this.otp});

  final String email, otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

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
                    decoration:
                        const InputDecoration(hintText: 'Confirm Password')),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<ResetPasswordController>(
                    builder: (resetPasswordController) {
                  return Visibility(
                    visible:
                        resetPasswordController.setPasswordInProgress == false,
                    replacement: const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapConfirmButton,
                      child: const Text('Confirm'),
                    ),
                  );
                }),
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

  void _onTapSignInButton() {
    Get.offAllNamed(signIn);
  }

  Future<void> _onTapConfirmButton() async {
    final ResetPasswordController resetPasswordController =
        Get.find<ResetPasswordController>();

    if (_passwordTEController.text == _confirmPasswordTEController.text) {
      bool isSuccess = await resetPasswordController.resetPassword(
          widget.email, widget.otp, _passwordTEController.text);

      if (isSuccess) {
        Get.offAllNamed(signIn);
      } else {
        if (mounted) {
          showSnackbarMessage(context, resetPasswordController.errorMessage);
        }
      }
    } else {
      showSnackbarMessage(context, 'Password reset failed! Please try again');
    }
  }
}
