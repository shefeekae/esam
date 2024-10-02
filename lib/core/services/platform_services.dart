import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/shared/functions/buildmaterialcolor.dart';

class PlatformServices {
  bool checkPlatformIsAndroid(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android;
  }

  // void showPlatformDialog(
  //   BuildContext context, {
  //   required String title,
  //   required String message,
  //   required void Function()? onPressed,
  // }) {
  //  bool isAndroid = checkPlatformIsAndroid(context);

  //   if (!isAndroid) {
  //     showCupertinoDialog(
  //       context: context,
  //       builder: (context) {
  //         return CupertinoAlertDialog(
  //           title: Text(title),
  //           content: Text(message),
  //           actions: [
  //             CupertinoDialogAction(
  //               child: Text('Cancel'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //              CupertinoDialogAction(
  //               child: Text('Ok'),
  //               onPressed: onPressed,

  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     return;
  //   }

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(message),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child:  Text('OK'),
  //             onPressed: onPressed,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // ==============================================================================
  // Show platform specific error dialog

  void showPlatformAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    bool isAndroid = checkPlatformIsAndroid(context);

    if (!isAndroid) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// ==========================================================================================
// This method is used to change the desing dialogbox to platform depending

  void showPlatformDialog(
    BuildContext context, {
    required String title,
    required String message,
    void Function()? onPressed,
  }) {
    bool isAndroid = checkPlatformIsAndroid(context);

    if (!isAndroid) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text('Yes'),
                onPressed: onPressed,
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: onPressed,
              ),
            ],
          );
        },
      );
    }
  }

// ============================================================================
// Currently its showing material ui date range picker.
//

  Future<DateTimeRange?> showPlatformDateRange(
    BuildContext context, {
    required DateTimeRange? initialDateRange,
    DateTime? firstDate,
    DateTime? endDate,
  }) async {
    // if (!isAndroid) {
    return await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: endDate ?? DateTime(3000),
      initialDateRange: initialDateRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.blue,
            primarySwatch: buildMaterialColor(Colors.orange),
            datePickerTheme: DatePickerThemeData(
              rangeSelectionBackgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            // appBarTheme: AppBarTheme(
            //   backgroundColor: primaryColor,
            // ),
            brightness: Theme.of(context).brightness,
          ).copyWith(
            colorScheme: Theme.of(context).brightness == Brightness.dark
                ? ColorScheme.dark(
                    primary: Theme.of(context).primaryColor,
                    onSurface: Theme.of(context).primaryColor,
                  )
                : ColorScheme.light(
                    primary: Theme.of(context).primaryColor,
                    onSurface: Theme.of(context).primaryColor,
                  ),
          ),
          child: child!,
        );
      },
    );
    // } else {
    //   showCupertinoModalPopup(
    //     context: context,
    //     builder: (context) {
    //       return Container(
    //         height: 40.h,
    //         color: kWhite,
    //         child: CupertinoTimerPicker(
    //           onTimerDurationChanged: (value) {},
    //         ),
    //       );
    //     },
    //   );
    // }
  }
}
