import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/screen/add_new_task.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/email_verification_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/pin_verification_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/reset_password_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/sign_in_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/sign_up_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/splash_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/cancelled_task_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/completed_task_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/in_progress_task_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/main_bottom_nav_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/new_task_screen.dart';
import 'package:task_manager_app_using_getx/ui/screen/update_profile_screen.dart';

const String splash = '/splash-screen';
const String signIn = '/signIn-screen';
const String signUp = '/signUp-screen';
const String resetPasword = '/resetPassword-screen';
const String pinVerification = '/pinVerification-screen';
const String emailVerification = '/emailVerification-screen';
const String addNewTask = '/addNewTask-screen';
const String cancelledTask = '/cancelledTask-screen';
const String completedTask = '/completedTask-screen';
const String inProgressTask = '/inProgressTask-screen';
const String newTask = '/NewTask-screen';
const String mainBottomNav = '/mainBottomNav-screen';
const String updateProfile = '/updateProfile-screen';

List<GetPage> getpages = [
  GetPage(
    name: splash,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: signIn,
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: signUp,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: resetPasword,
    page: () => ResetPasswordScreen(
      email: Get.arguments['email'],
      otp: Get.arguments['otp'],
    ),
  ),
  GetPage(
    name: pinVerification,
    page: () => PinVerificationScreen(email: Get.arguments['email']),
  ),
  GetPage(
    name: emailVerification,
    page: () => const EmailVerificationScreen(),
  ),
  GetPage(
    name: addNewTask,
    page: () => const AddNewTaskScreen(),
  ),
  GetPage(
    name: cancelledTask,
    page: () => const CancelledTaskScreen(),
  ),
  GetPage(
    name: completedTask,
    page: () => const CompletedTaskScreen(),
  ),
  GetPage(
    name: inProgressTask,
    page: () => const InProgressTaskScreen(),
  ),
  GetPage(
    name: newTask,
    page: () => const NewTaskScreen(),
  ),
  GetPage(
    name: mainBottomNav,
    page: () => const MainBottomNavigationScreen(),
  ),
  GetPage(
    name: updateProfile,
    page: () => const UpdateProfileScreen(),
  ),
];
