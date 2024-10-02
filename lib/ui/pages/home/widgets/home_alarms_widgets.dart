import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class AlarmCountWidget extends StatelessWidget {
  final List<Color>? grdientColors;
  final String label;
  final IconData iconData;
  final String value;
  final Color? color;

  const AlarmCountWidget({
    Key? key,
    required this.label,
    required this.iconData,
    required this.value,
    this.grdientColors,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 90.sp,
      // color: Colors.blue,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        gradient: grdientColors == null
            ? null
            : LinearGradient(
                colors: grdientColors ?? [],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: 0.8,
              child: Row(
                children: [
                  Icon(
                    iconData,
                    color: kWhite,
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: kWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
