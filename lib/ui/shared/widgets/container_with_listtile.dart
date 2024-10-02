import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import '../../../utils/constants/colors.dart';

class ContainerWithListTile extends StatelessWidget {
  const ContainerWithListTile({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    this.onTap,
    this.titleTextStyle,
    this.bgColor,
  });

  final String title;
  final Widget? trailing;
  final Widget? leading;
  final void Function()? onTap;
  final TextStyle? titleTextStyle;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: bgColor ?? ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        minVerticalPadding: 0,
        onTap: onTap,
        leading: leading,
        title: Text(
          title,
          style: titleTextStyle,
          // style: TextStyle(
          //   fontWeight: FontWeight.w600,
          //   fontSize: 10.sp,
          //   color: kGrey,
          // ),
        ),
        trailing: trailing,
      ),
    );
  }
}
