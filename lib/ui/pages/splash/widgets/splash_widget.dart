import 'package:apptheme_pkg/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/widgets/logo/logo_widget.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeServices().getGradientColors(
          context,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  "assets/images/esam_dark.png",
                  height: 40.sp,
                ),
                const Spacer(),
                LogoWidget(
                  width: 30.w,
                  showLightModeLogo: false,
                ),
                const Spacer(),
                Text(
                  "Powered By Nectar",
                  style: TextStyle(
                    color: kBlack,
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  // =======================================================================================
  // Showing the default logo.

  Hero buildDefaultLogo(Size size) {
    return Hero(
      tag: "logo",
      transitionOnUserGestures: true,
      child: Image.asset(
        "assets/images/nectar-main.png",
        width: size.width * 0.5,
        package: "apptheme_pkg",
      ),
    );
  }
}
