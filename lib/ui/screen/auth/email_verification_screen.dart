import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';
import 'package:task_manager_app_using_getx/ui/controller/email_verification_controller.dart';

import '../../utility/app_colors.dart';
import '../../utility/app_constants.dart';
import '../../widget/background_widget.dart';
import '../../widget/center_progress_indicator.dart';
import '../../widget/snackbar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Your Email Address',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      Text(
                        'A 6 digits verification pin will be sent to your email address',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          controller: _emailTEController,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String? value) {
                            if (value
                                ?.trim()
                                .isEmpty ?? true) {
                              return 'Enter your email';
                            }
                            if (AppConstants.emailRegExp.hasMatch(value!) ==
                                false) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: 'Email')),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<EmailVerificationController>(builder: (emailVerificationController) {
                        return Visibility(
                          visible: emailVerificationController.emailVerificationInProgress == false,
                          replacement: const CenterProgressIndicator(),
                          child: ElevatedButton(
                            onPressed:
                            _onTapConfirmButton,
                            child: const Icon(Icons.arrow_forward_ios_rounded),
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
                                  style: const TextStyle(
                                      color: AppColors.themeColor),
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
              ),
            )),
      ),
    );
  }


  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  Future<void> _onTapConfirmButton() async {
    final EmailVerificationController emailVerificationController = Get.find<EmailVerificationController>();final result = await emailVerificationController.verifyEmail(_emailTEController.text.trim());
    if (result) {
      Get.toNamed(pinVerification, arguments: {
        'email': _emailTEController.text.trim(),
      });
    } else {
      showSnackbarMessage(context, emailVerificationController.errorMessage);
    }
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
