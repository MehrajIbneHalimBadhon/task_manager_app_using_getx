import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';
import 'package:task_manager_app_using_getx/ui/controller/sign_up_controller.dart';

import '../../utility/app_colors.dart';
import '../../utility/app_constants.dart';
import '../../widget/background_widget.dart';
import '../../widget/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

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
                    'Join With Us',
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
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        if (AppConstants.mobileRegExp.hasMatch(value!) ==
                            false) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: _showPassword == false,
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          icon: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<SignUpController>(builder: (signUpController) {
                    return Visibility(
                      visible: signUpController.registrationInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _registerUser();
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 36,
                  ),
                  _buildBackToSignInSection()
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildBackToSignInSection() {
    return Center(
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
                recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
              ),
            ]),
      ),
    );
  }

  Future<void> _registerUser() async {
    final SignUpController signUpController = Get.find<SignUpController>();
    final result = await signUpController.registerUser(
        _emailTEController.text.trim(),
        _firstNameTEController.text.trim(),
        _lastNameTEController.text.trim(),
        _mobileTEController.text.trim(),
        _passwordTEController.text);
    if (result) {
      _clearTextFields();
      showSnackbarMessage(context, 'Registration successful');
      Get.offAll(() => mainBottomNav);
    } else {
      showSnackbarMessage(context,
          signUpController.errorMessage);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
