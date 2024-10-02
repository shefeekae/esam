import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    this.child,
  });

  final String title;
  final String value;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Color primaryFgColor = ThemeServices().getPrimaryFgColor(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: color,
      ),
      width: 120.sp,
      padding: EdgeInsets.all(5.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              color: primaryFgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: primaryFgColor,
              ),
            ),
          ),
          Visibility(
              visible: child != null,
              child: Expanded(child: child ?? const SizedBox()))
        ],
      ),
    );
  }
}
