import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';

import '../controller/auth_controller.dart';
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
        Get.toNamed(updateProfile);
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
        Get.toNamed(updateProfile);
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
            Get.offAllNamed(signIn);
          },
          icon: const Icon(Icons.logout_outlined))
    ],
  );
}
