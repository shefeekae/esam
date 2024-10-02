


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildCustomListTile extends StatelessWidget {
  const BuildCustomListTile({
    required this.titleText,
    required this.iconData,
    this.showForwardArrowIcon = false,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String titleText;
  final IconData iconData;
  final bool showForwardArrowIcon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        // color: kBlack,
      ),
      title: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          trailing ?? const SizedBox(),
          Visibility(
            visible: showForwardArrowIcon,
            // maintainSize: true,
            // maintainAnimation: true,
            // maintainState: true,
            child: Padding(
              padding: EdgeInsets.only(left: 5.sp),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 8.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
