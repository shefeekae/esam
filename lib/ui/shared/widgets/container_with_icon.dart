import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class ContainerWithIcon extends StatelessWidget {
  const ContainerWithIcon({
    super.key,
    required this.iconData,
    this.bgColor,
    this.iconColor,
  });

  final Color? bgColor;
  final Color? iconColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(7),
      ),
      padding: EdgeInsets.all(3.sp),
      child: Icon(
        iconData,
        color: iconColor ?? kWhite,
      ),
    );
  }
}
