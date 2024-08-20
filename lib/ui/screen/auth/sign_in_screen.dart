import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';

import '../../controller/sign_in_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/app_constants.dart';
import '../../widget/background_widget.dart';
import '../../widget/center_progress_indicator.dart';
import '../../widget/snackbar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      if (AppConstants.emailRegExp.hasMatch(value!) == false) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    controller: _passwordTEController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<SignInController>(
                      init: SignInController(),
                      builder: (signInController) {
                    return Visibility(
                      visible: signInController.signInApiInProgress == false,
                      replacement: const CenterProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapNextButton,
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 36,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () => _onTapForgetPasswordButton(),
                          child: const Text('Forget Password'),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4),
                              text: "Don't have an account? ",
                              children: [
                                TextSpan(
                                  style: const TextStyle(
                                      color: AppColors.themeColor),
                                  text: "Sign up",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignUpButton,
                                ),
                              ]),
                        )
                      ],
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

  Future<void> _onTapNextButton() async {
    if (_formKey.currentState?.validate() ?? false) {
      final SignInController signInController = Get.find<SignInController>();
      final bool result = await signInController.signIn(
          _emailTEController.text.trim(), _passwordTEController.text);
      if (result) {
        Get.offAllNamed(mainBottomNav);
      } else {
        if (mounted) {
          showSnackbarMessage(context, signInController.errorMessage);
        }
      }
    }
  }

  void _onTapSignUpButton() {
    Get.toNamed(signUp);
  }

  void _onTapForgetPasswordButton() {
    Get.toNamed(emailVerification);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
