import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_app_using_getx/ui/controller/auth_controller.dart';
import '../../app.dart';
import '../../ui/screen/auth/sign_in_screen.dart';
import '../model/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      debugPrint('URL: $url');
      http.Response response = await http.get(Uri.parse(url), headers: {
        'token': AuthController.accessToken,
      });
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseDate: decodedData,
        );
      } else if (response.statusCode == 401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Failed with status code: ${response.statusCode}');
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1,
          isSuccess: false,
          errorMessage: 'An error occurred: $e');
    }
  }

  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      debugPrint('URL: $url');
      debugPrint('Request Body: $body');

      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken,
        },
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseDate: decodedData,
        );
      }
      else if (response.statusCode == 401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            errorMessage: 'Failed with status code: ${response.statusCode}');
      }
      else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: 'Failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1,
          isSuccess: false,
          errorMessage: 'An error occurred: $e');
    }
  }

 static Future<void> redirectLogin() async {
    await AuthController.clearAllData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }
}
