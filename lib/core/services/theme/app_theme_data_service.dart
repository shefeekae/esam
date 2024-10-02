
import 'package:apptheme_pkg/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import '../../../ui/shared/functions/buildmaterialcolor.dart';

class AppThemeData {
  ThemeServices themeServices = ThemeServices();

//  ============================================================

  ThemeData getThemeData({
    required bool lightMode,
    required Color defaultPrimaryColor,
    required Color defaultSecondary,
    ThemeData? themeData,
    Color? defaultAccent,
    Color? scaffoldBgColor,
  }) {
    themeData ??= ThemeData();

    // String? data = SharedPrefrencesServices().getData(key: "appTheme");

    // Map appTheme = data == null ? {} : jsonDecode(data);

    // Color? savedPrimary =
    //     appTheme['primary'] == null ? null : HexColor(appTheme['primary']);
    // Color? savedSecondary =
    //     appTheme['secondary'] == null ? null : HexColor(appTheme['secondary']);

    // Color? savedAccent =
    //     appTheme['accent'] == null ? null : HexColor(appTheme['accent']);

    // Color primaryFgColor =
    //     ThemeServices().isLightColor(savedPrimary ?? defaultPrimaryColor)
    //         ? kBlack
    //         : kWhite;

    Color primaryColor =  defaultPrimaryColor;

    return lightMode
        ? ThemeData(
            useMaterial3: false,
            brightness: Brightness.light,
            scaffoldBackgroundColor: scaffoldBgColor ?? kF1White,
            primaryColor: primaryColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor:  primaryColor,
              secondary:  defaultAccent,
              secondaryContainer:  defaultSecondary,
            ),
            appBarTheme: AppBarTheme(
              centerTitle: themeData.appBarTheme.centerTitle ?? false,
              backgroundColor:
                  themeData.appBarTheme.backgroundColor ?? kF1White,
              elevation: themeData.appBarTheme.elevation ?? 0,
              foregroundColor:
                  themeData.appBarTheme.foregroundColor ?? Colors.black,
              // titleTextStyle: TextStyle(
              //   fontWeight: FontWeight.bold,
              //   color: kBlack,
              //   // fontSize: 15.sp,
              // ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            )),
            primarySwatch: buildMaterialColor(primaryColor),
            // primaryColorDark: buildMaterialColor(primaryColor),
          )
        // .copyWith(
        //   appBarTheme: themeData.appBarTheme,
        //   elevatedButtonTheme: themeData.elevatedButtonTheme,
        //   scaffoldBackgroundColor: themeData.scaffoldBackgroundColor,
        // )
        : ThemeData(
            useMaterial3: false,
            primaryColor: primaryColor,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor:  primaryColor,
              secondary:  defaultAccent,
              secondaryContainer:  defaultSecondary,
              brightness: Brightness.dark,
            ),
            appBarTheme: AppBarTheme(
              centerTitle: themeData.appBarTheme.centerTitle ?? false,
              backgroundColor:
                  themeData.appBarTheme.backgroundColor ?? Colors.transparent,
              elevation: themeData.appBarTheme.elevation ?? 0,
              // titleTextStyle: TextStyle(
              //   fontWeight: FontWeight.bold,
              //   // fontSize: 15.sp,
              // ),
            ),
            primarySwatch: buildMaterialColor(primaryColor),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
            ),
          );
    // .copyWith(
    //   appBarTheme: themeData.appBarTheme,
    //   elevatedButtonTheme: themeData.elevatedButtonTheme,
    //   scaffoldBackgroundColor: themeData.scaffoldBackgroundColor,
    // );
  }
}
