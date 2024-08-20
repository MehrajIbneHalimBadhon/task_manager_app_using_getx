import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app_using_getx/route/route.dart';
import 'package:task_manager_app_using_getx/ui/controller/pin_verification_controller.dart';

import '../../utility/app_colors.dart';
import '../../widget/background_widget.dart';
import '../../widget/center_progress_indicator.dart';
import '../../widget/snackbar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();

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
                  const SizedBox(height: 100),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits verification pin has been sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildPinCodeTextField(),
                  const SizedBox(height: 16),
                  GetBuilder<PinVerificationController>(
                      builder: (pinVerificationController) {
                    return Visibility(
                      visible:
                          pinVerificationController.otpVerificationInProgress ==
                              false,
                      replacement: const CenterProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapVerifyOtpButton,
                        child: const Text('Verify'),
                      ),
                    );
                  }),
                  const SizedBox(height: 36),
                  _buildSignInSection()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          text: "Have account? ",
          children: [
            TextSpan(
              text: 'Sign in',
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      controller: _pinTEController,
      appContext: context,
    );
  }

  void _onTapSignInButton() {
    Get.offAllNamed(signIn);
  }

  Future<void> _onTapVerifyOtpButton() async {
    final PinVerificationController pinVerificationController =
        Get.find<PinVerificationController>();
    final result = await pinVerificationController.verifyOTP(
        widget.email, _pinTEController.text);
    if (result) {
      Get.toNamed(
        resetPasword,
        arguments: {
          'email': widget.email,
          'otp': _pinTEController.text,
        },
      );
    } else {
      showSnackbarMessage(context, pinVerificationController.errorMessage);
    }
  }
}
