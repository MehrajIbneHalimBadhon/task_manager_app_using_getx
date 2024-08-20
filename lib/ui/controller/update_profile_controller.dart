import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/network_response.dart';
import '../../data/model/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;
  set selectedImage (XFile? value){
    _selectedImage = value;
    update();
  }

  bool get updateProfileInProgress => _updateProfileInProgress;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;


  // Future<bool> _updateProfile(String email, String firstName, String lastName, String mobile, String password) async {
  //   _updateProfileInProgress = true;
  //   String encodedPhoto = AuthController.userData?.photo ?? '';
  //   update();
  //
  //   Map<String, dynamic> requestBody = {
  //     "email": email,
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "mobile": mobile,
  //   };
  //
  //   if (password.isNotEmpty) {
  //     requestBody['password'] = password;
  //   }
  //   if (_selectedImage != null) {
  //     File file = File(_selectedImage!.path);
  //     encodedPhoto = base64Encode(file.readAsBytesSync());
  //     requestBody['photo'] = encodedPhoto;
  //   }
  //
  //   final NetworkResponse response =
  //   await NetworkCaller.postRequest(Urls.updateProfile, body: requestBody);
  //
  //   _updateProfileInProgress = false;
  //
  //   if (response.isSuccess && response.responseDate['status'] == 'success') {
  //     UserModel userModel = UserModel(
  //         email: email,
  //         photo: encodedPhoto,
  //         firstName: firstName,
  //         lastName: lastName,
  //         mobile: mobile);
  //
  //     await AuthController.saveUserData(userModel);
  //
  //     // Reset the selected image after successful update
  //     _selectedImage = null;
  //
  //     update();
  //     return true; // Indicate success
  //   } else {
  //     _errorMessage = 'Profile update failed! Try again';
  //     update(); // Update the UI to reflect the error
  //     return false; // Indicate failure
  //   }
  // }

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    String encodedPhoto = AuthController.userData?.photo ?? '';
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      requestBody['password'] = password;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodedPhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodedPhoto;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.updateProfile, body: requestBody);
    if (response.isSuccess && response.responseDate['status'] == 'success') {
      UserModel userModel = UserModel(
          email: email,
          photo: encodedPhoto,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile);
      await AuthController.saveUserData(userModel);
      update();
      isSuccess = true;
    } else {
      _errorMessage = 'Profile Update Failed! Please try again';
    }
    _updateProfileInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> pickProfileImage() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? result =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        _selectedImage = result;
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error picking image: $e';
      update();
      return false;
    }
  }
}
