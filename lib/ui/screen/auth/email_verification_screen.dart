import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/pin_verification_screen.dart';

import '../../../data/model/network_response.dart';
import '../../../data/network_caller/network_caller.dart';
import '../../../data/utilities/urls.dart';
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
  bool _emailVerificationInProgress = false;
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits verification pin will be sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        if (AppConstants.emailRegExp.hasMatch(value!) == false) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Email')),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _emailVerificationInProgress == false,
                    replacement: const CenterProgressIndicator(),
                    child: ElevatedButton(
                      onPressed:
                          _onTapConfirmButton,
                      child: const Icon(Icons.arrow_forward_ios_rounded),
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
          ),
        )),
      ),
    );
  }


  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  void _onTapConfirmButton() {
    _verifyEmail(_emailTEController.text.trim());
  }

  Future<void> _verifyEmail(String email) async {
    _emailVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyEmail(email));
    _emailVerificationInProgress = false;
    if(mounted){
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerificationScreen(email: email,),
          ),
        );
      }
    } else {
      if (mounted) {
        showSnackbarMessage(context,
            response.errorMessage ?? 'Email Verification Failed! Try Again');
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
