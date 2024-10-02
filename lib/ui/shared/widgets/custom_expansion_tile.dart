import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/colors.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile(
      {super.key,
      required this.children,
      this.title,
      this.initiallyExpanded = false,
      this.bgColor,
      this.titleWidget,
      this.titleColor,
      this.subTitle,
      this.subTitleStyle,
      this.onExpansionChanged,
      this.controller,
      this.trailing});

  final String? title;
  final List<Widget> children;
  final Color? bgColor;
  final bool initiallyExpanded;
  final Widget? titleWidget;
  final Color? titleColor;
  final String? subTitle;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final ExpansionTileController? controller;
  final TextStyle? subTitleStyle;

  @override
  Widget build(BuildContext context) {
    ThemeData data = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Theme(
        data: data.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          controller: controller,
          childrenPadding:
              EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 5.sp),
          initiallyExpanded: initiallyExpanded,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: bgColor ?? ThemeServices().getBgColor(context),
          collapsedBackgroundColor:
              bgColor ?? ThemeServices().getBgColor(context),
          onExpansionChanged: onExpansionChanged,
          title: titleWidget ??
              Text(
                title ?? "No Title",
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
          subtitle: subTitle == null
              ? null
              : Text(
                  subTitle!,
                  style: subTitleStyle,
                ),
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
