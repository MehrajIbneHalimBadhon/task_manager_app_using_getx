import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/completed_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/email_verification_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/in_progress_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/new_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/pin_verification_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/reset_password_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/sign_in_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/sign_up_controller.dart';
import 'package:task_manager_app_using_getx/ui/controller/update_profile_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put( SignInController());
    Get.put(SignUpController());
    Get.put( EmailVerificationController());
    Get.put( ResetPasswordController());
    Get.put( PinVerificationController());
    Get.put( UpdateProfileController());
    Get.put(NewTaskController());
    Get.put( AddNewTaskController());
    Get.put( CompletedTaskController());
    Get.put(InProgressTaskController());
    Get.put( CancelledTaskController());

  }

}