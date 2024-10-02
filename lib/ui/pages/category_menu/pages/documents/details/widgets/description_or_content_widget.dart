
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DescriptionOrContentWidget extends StatelessWidget {
  const DescriptionOrContentWidget({
    super.key,
    required this.content,
    required this.title,
  });

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title :",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}