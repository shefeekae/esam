import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:nectar_assets/utils/constants/styles.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class BuildAssetPathFooter extends StatelessWidget {
  BuildAssetPathFooter({
    super.key,
    required this.borderRadius,
    required this.assetPath,
  });

  final double borderRadius;

  String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: linearGradientPrimaryTheme,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          assetPath,
          textAlign: TextAlign.end,
          style: TextStyle(
            color: kWhite,
            fontSize: 8.sp,
          ),
        ),
      ),
    );
  }
}
