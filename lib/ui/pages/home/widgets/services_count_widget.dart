import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
// import '../../../../utils/constants/colors.dart';

class ServicesCountWidget extends StatelessWidget {
  const ServicesCountWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 90.sp,
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: 55.sp,
            height: 45.sp,
            child: FittedBox(
              child: Text(
                value,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
