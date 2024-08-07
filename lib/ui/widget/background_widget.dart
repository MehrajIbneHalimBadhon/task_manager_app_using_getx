import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utility/asset_path.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetPath.backgroundSVG,
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          child,
        ],
      ),
    );
  }
}
