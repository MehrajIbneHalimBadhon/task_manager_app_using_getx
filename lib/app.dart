import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/controller_binding.dart';
import 'package:task_manager_app_using_getx/route/route.dart';
import 'package:task_manager_app_using_getx/ui/utility/app_colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      getPages: getpages,
      initialRoute: splash,
      theme: lightTheme(),
      initialBinding: ControllerBinder(),
    );
  }
}

ThemeData lightTheme() {
  return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              color: Colors.grey)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          foregroundColor: AppColors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
              textStyle: const TextStyle(fontWeight: FontWeight.w600))));
}
