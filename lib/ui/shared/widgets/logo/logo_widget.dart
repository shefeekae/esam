import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    this.width,
    this.height,
    this.showLightModeLogo,
    super.key,
  });

  final double? width;
  final double? height;
  final bool? showLightModeLogo;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        showLightModeLogo ?? Brightness.dark == Theme.of(context).brightness;

    return Hero(
      tag: "logo",
      transitionOnUserGestures: true,
      child: SvgPicture.asset(
        isDarkMode
            ? "assets/images/ECM-White.svg"
            : "assets/images/emaar-logo-dark.svg",
        width: width,
        height: height,
      ),
    );
  }
}
