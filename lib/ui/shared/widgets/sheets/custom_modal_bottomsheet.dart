import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';




showCustomModalBottomSheet({
  required BuildContext context,
  required Widget child,
}) {


  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Brightness.dark == Theme.of(context).brightness
        ? Theme.of(context).scaffoldBackgroundColor
        : f1White,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(5),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: 80.h,
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: child,
        ),
      );
    },
  );
}
