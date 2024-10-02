import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/services/theme/theme_services.dart';

class BgContainer extends StatelessWidget {
  const BgContainer(
      {required this.child,
      this.padding,
      this.margin,
      this.title = "",
      this.titilePadding,
      super.key, this.height});

  final Widget child;
  final EdgeInsets? padding;
  final String title;
  final EdgeInsets? titilePadding;
  final EdgeInsets? margin;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Builder(builder: (context) {
        if (title.isEmpty) {
          return child;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: titilePadding ??
                  EdgeInsets.only(left: 7.sp, right: 7.sp, top: 7.sp),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child,
          ],
        );
      }),
    );
  }
}
