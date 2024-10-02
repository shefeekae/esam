

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';

class CircleAvatarWithText extends StatelessWidget {
  const CircleAvatarWithText({
    super.key,
    required this.value,
    this.bgColor,
    this.fgColor,
    this.maxRadius,
  });

  final String value;
  final Color? bgColor;
  final Color? fgColor;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: maxRadius ?? 10.sp,
      backgroundColor: bgColor,
      child: Text(
        value,
        style: TextStyle(
          color: fgColor ?? kWhite,
        ),
      ),
    );
  }
}