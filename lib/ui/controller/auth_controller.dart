import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app_using_getx/data/model/user_model.dart';


class AuthController {
  static const String _accessTokenKey = 'acess-token';
  static const String _userDatakey = 'user-data';
  static String accessToken = '';
  static UserModel? userData ;

  static Future<void> saveUserAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserData(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      _userDatakey,
      jsonEncode(
        user.toJson(),
      ),
    );
    userData = user;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_userDatakey);
    if (data == null) return null;
    UserModel userModel = UserModel.fromJson(
      jsonDecode(data),
    );
    return userModel;
  }

  static Future<bool> checkAuthState() async {
    String? token = await getUserAccessToken();
    if (token == null) return false;
    accessToken = token;
    userData = (await getUserData());
    return true;
  }
  static Future<void> clearAllData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<void> emailVerification(Email)async{
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('EmailVerificaion', Email);
  }
  static Future<void> otpVerification(OTP)async{
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('OTPVerificaion', OTP);
  }
}
