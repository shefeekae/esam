import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class DocumentCountWidget extends StatelessWidget {
  const DocumentCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 90.sp,
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Documents Expiring In 24 hours",
              style: TextStyle(
                fontSize: 10.sp,
                color: kWhite,
              ),
            ),
            const Spacer(),
            FittedBox(
              child: Text(
                "10",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
