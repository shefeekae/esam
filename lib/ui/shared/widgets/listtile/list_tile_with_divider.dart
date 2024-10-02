import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../container_with_icon.dart';

class ListTielWithDivider extends StatelessWidget {
  final IconData leadingIconData;
  final String title;
  final Widget? trailing;
  final String? trailingText;
  final bool isLast;
  final int maxLines;
  final bool showToolTip;

  const ListTielWithDivider({
    Key? key,
    required this.leadingIconData,
    required this.title,
    this.trailing,
    this.trailingText,
    this.isLast = false,
    this.maxLines = 1,
    this.showToolTip = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          minLeadingWidth: 10.sp,
          leading: ContainerWithIcon(
            iconData: leadingIconData,
          ),
          title: Text(
            title,
          ),
          trailing: trailingText == null
              ? trailing
              : Tooltip(
                  message: trailingText,
                  triggerMode: showToolTip
                      ? TooltipTriggerMode.tap
                      : TooltipTriggerMode.manual,
                  waitDuration: const Duration(seconds: 5),
                  child: SizedBox(
                    width: 120.sp,
                    child: Text(
                      trailingText ?? "",
                      textAlign: TextAlign.end,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
        ),
        Visibility(
          visible: !isLast,
          child: const Divider(
            height: 0,
            indent: 15,
            endIndent: 15,
            // color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
