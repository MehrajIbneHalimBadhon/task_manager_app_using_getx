import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/route/route.dart';

import '../../controller/auth_controller.dart';
import '../../utility/asset_path.dart';
import '../../widget/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isUserLoggedIn = await AuthController.checkAuthState();
    if (mounted) {
      if (isUserLoggedIn) {
        Get.offAllNamed(mainBottomNav);
      } else {
        Get.offAllNamed(signIn);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
            child: SvgPicture.asset(
          AssetPath.logoSVG,
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
