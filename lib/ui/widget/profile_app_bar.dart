import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import '../screen/auth/sign_in_screen.dart';
import '../screen/update_profile_screen.dart';
import '../utility/app_colors.dart';

AppBar profileAppBar(context, [bool fromUpdateProfile = false]) {
  double avatarSize = MediaQuery.of(context).size.width * 0.12;
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: avatarSize / 2,
          child: ClipOval(
            child: Image.memory(
              base64Decode(AuthController.userData?.photo ?? ''),
              fit: BoxFit.cover,
              width: avatarSize,
              height: avatarSize,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Icon(Icons.error_outline_rounded, size: avatarSize);
              },
            ),
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData?.fullName ?? '',
            style: const TextStyle(fontSize: 16, color: AppColors.white),
          ),
          Text(
            AuthController.userData?.email ?? '',
            style: const TextStyle(
                fontSize: 12,
                color: AppColors.white,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            await AuthController.clearAllData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
                (route) => false);
          },
          icon: const Icon(Icons.logout_outlined))
    ],
  );
}
