import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CircleAvatarWithIcon extends StatelessWidget {
  const CircleAvatarWithIcon({
    super.key,
    required this.iconData,
    this.bgColor,
    this.maxRadius,
    this.iconSize,
    this.iconColor,
  });

  final IconData iconData;
  final Color? bgColor;
  final double? maxRadius;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: maxRadius ?? 15.sp,
      backgroundColor: bgColor ?? f1White,
      child: Icon(
        iconData,
        color: iconColor ?? kBlack,
        size: iconSize,
        
      ),
    );
  }
}
