import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class NoAccessImageWidget extends StatelessWidget {
  const NoAccessImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/images/access_denied.svg",
          height: 30.h,
        ),
        SizedBox(
          height: 10.sp,
        ),
        Text(
          "No Access",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
