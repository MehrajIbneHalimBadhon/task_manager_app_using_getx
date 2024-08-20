import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/controller/update_profile_controller.dart';
import 'package:task_manager_app_using_getx/ui/screen/main_bottom_nav_screen.dart';

import '../controller/auth_controller.dart';
import '../utility/app_colors.dart';
import '../widget/background_widget.dart';
import '../widget/center_progress_indicator.dart';
import '../widget/profile_app_bar.dart';
import '../widget/snackbar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
   final userData = AuthController.userData;
    _emailTEController.text = userData?.email ?? '';
    _firstNameTEController.text =  userData?.firstName ?? '';
    _lastNameTEController.text =  userData?.lastName ?? '';
    _mobileTEController.text =  userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GetBuilder<UpdateProfileController>(
                      builder: (updateProfileController) {
                    return _buildPhotoPickerWidget(updateProfileController);
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<UpdateProfileController>(
                      builder: (updateProfileController) {
                    return Visibility(
                      visible:
                          updateProfileController.updateProfileInProgress ==
                              false,
                      replacement: const CenterProgressIndicator(),
                      child: ElevatedButton(
                          onPressed:()=> _updateProfile(updateProfileController),
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _updateProfile(UpdateProfileController updateProfileController) async {
    if (_formKey.currentState?.validate() ?? false) {
      final bool result = await updateProfileController.updateProfile(
        _emailTEController.text.trim(),
        _firstNameTEController.text.trim(),
        _lastNameTEController.text.trim(),
        _mobileTEController.text.trim(),
        _passwordTEController.text,
      );

      if (result) {
        Get.offAll(() => const MainBottomNavigationScreen());
        showSnackbarMessage(context, 'Profile Updated');
      } else {
        showSnackbarMessage(context, updateProfileController.errorMessage);
      }
    }
  }

  Widget _buildPhotoPickerWidget(
      UpdateProfileController updateProfileController) {
    return GestureDetector(
      onTap: () => updateProfileController.pickProfileImage(),
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: AppColors.white),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Colors.grey),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                updateProfileController.selectedImage?.name ??
                    'No image selected', // Use the provided controller instance
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
