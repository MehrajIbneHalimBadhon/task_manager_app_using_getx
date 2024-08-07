import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app_using_getx/ui/screen/auth/sign_in_screen.dart';

import '../../controller/auth_controller.dart';
import '../../utility/asset_path.dart';
import '../../widget/background_widget.dart';
import '../main_bottom_nav_screen.dart';

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isUserLoggedIn
                  ?  const MainBottomNavigationScreen()
                  : const SignInScreen(),
        ),
      );
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
