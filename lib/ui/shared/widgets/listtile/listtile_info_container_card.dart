import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import 'list_tile_with_divider.dart';

class ContainerInfoCardWithDivider extends StatelessWidget {
  const ContainerInfoCardWithDivider({
    super.key,
    required this.children,
    this.title,
  });

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Visibility(
            visible: title != null,
            child: ListTile(
              title: Text(
                title ?? "N/A",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              minVerticalPadding: 0,
            ),
          ),
          Column(children: children
              // .map((e) => ListTielWithDivider(
              //       leadingIconData: e.leadingIconData,
              //       title: e.title,
              //       isLast: children.indexOf(e) == children.length - 1,
              //       trailing: e.trailing,
              //       trailingText: e.trailingText,
              //     ))
              // .toList(),
              ),
        ],
      ),
    );
  }
}
