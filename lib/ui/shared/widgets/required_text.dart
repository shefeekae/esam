import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RequiredTextWidget extends StatelessWidget {
  const RequiredTextWidget({
    super.key,
    required this.title,
    this.required = true,
  });

  final String title;
  final bool required;

  @override
  Widget build(BuildContext context) {
    if (!required) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Row(
      children: [
        Text(
          "*",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.red,
          ),
        ),
        SizedBox(
          width: 3.sp,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
