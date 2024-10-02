import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

class ContainerWithTextWidget extends StatelessWidget {
  final Color? bgColor;
  final String value;
  final Color? fgColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final double? fontSize;

  const ContainerWithTextWidget(
      {Key? key,
      required this.value,
      this.fgColor,
      this.borderRadius,
      this.bgColor,
      this.textStyle,
      this.fontSize,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      padding: padding ?? EdgeInsets.all(3.sp),
      child: Text(
        value,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: textStyle ??
            TextStyle(
              color: fgColor ?? ThemeServices().getPrimaryFgColor(context),
              fontSize: fontSize ?? 7.sp,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
