import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/services/panels/panels_instights_charts_services.dart';
import '../../../../../../../utils/constants/colors.dart';

class FirePanelStatusCard extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String value;
  final bool isLoading;
  const FirePanelStatusCard({
    Key? key,
    required this.bgColor,
    required this.title,
    required this.value,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        if (value == "0") {
          return;
        }

        PanelsInsightsServices().goToAlarmPage(context, title: title);

        
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 2.sp),
        width: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // SizedBox(
            //   width: 5.sp,
            // ),
            Skeletonizer(
              enabled: isLoading,
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
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
