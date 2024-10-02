import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.fgColor,
    this.isLoading = false,
  });

  final String title;
  final void Function()? onPressed;
  final Color? fgColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.sp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 35.sp),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Builder(builder: (context) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: fgColor ?? ThemeServices().getPrimaryFgColor(context),
            ),
          );
        }),
      ),
    );
  }
}
