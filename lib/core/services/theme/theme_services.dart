import 'package:apptheme_pkg/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';

class ThemeServices {
  Color getBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black26
        : kWhite;
  }

  Color getContainerBgColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black26
        : f1White;
  }

  ThemeData getSearchThemeData(BuildContext context,
          {Color? scaffoldBackgroundColor}) =>
      AppThemeData()
          .getThemeData(
            lightMode: Theme.of(context).brightness == Brightness.light,
            defaultPrimaryColor: primaryColor,
            defaultSecondary: primaryColor,
            // themeData: lightMode
            //     ? ThemeData(scaffoldBackgroundColor: f1White,)
            //     : ThemeData(),
          )
          .copyWith(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          );

  Color getLabelColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? kWhite : kBlack;
  }

  bool isLightColor(Color color) {
    // Calculate the luminance of the color
    final luminance = color.computeLuminance();

    // Determine the threshold for considering a color as light or dark
    // You can adjust this threshold as needed
    const threshold = 0.5;

    // Compare the luminance with the threshold
    return luminance > threshold;
  }

  Color getPrimaryFgColor(BuildContext context) {
    return isLightColor(Theme.of(context).primaryColor) ? kBlack : kWhite;
  }

  Color getSecondaryFgColor(BuildContext context) {
    return isLightColor(Theme.of(context).colorScheme.secondary)
        ? kBlack
        : kWhite;
  }

  Color getFgColor(Color color) {
    return isLightColor(color) ? kBlack : kWhite;
  }
}
