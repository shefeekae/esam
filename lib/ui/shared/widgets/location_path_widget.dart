import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LocationPathWidget extends StatelessWidget {
  const LocationPathWidget({
    super.key,
    required this.value,
    this.fontSize,
    this.fontWeight,
  });

  final String value;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 12.sp,
          color: Colors.blue,
        ),
        SizedBox(
          width: 2.sp,
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: fontSize ?? 10.sp,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
