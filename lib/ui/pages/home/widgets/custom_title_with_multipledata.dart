import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class CustomTileWithMultipleData extends StatelessWidget {
  const CustomTileWithMultipleData({
    super.key,
    required this.items,
    required this.title,
    this.value,
  });

  final String title;
  final String? value;
  final List<Map> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 90.w,
      // height: 90.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ThemeServices().getBgColor(context),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: listTile(
              title: title,
              value: value ?? "",
              titleFontSize: 12.sp,
              fgColor: kWhite,
            ),
          ),
          ...List.generate(items.length, (index) {
            var map = items[index];
            String title = map['title'];
            String value = map['value'] ?? "";
            IconData? iconData = map["icon"];
            Color? iconColor = map['iconColor'];

            if (items.length - 1 == index) {
              return listTile(
                title: title,
                value: value,
                iconData: iconData,
                iconColor: iconColor,
              );
            }

            return Column(
              children: [
                listTile(
                  title: title,
                  value: value,
                  iconData: iconData,
                  iconColor: iconColor,
                ),
                const Divider(
                  height: 0,
                )
              ],
            );
          })
        ],
      ),
    );
  }

  // ====================================================================

  ListTile listTile({
    required String title,
    required String value,
    Color? fgColor,
    double? titleFontSize,
    IconData? iconData,
    Color? iconColor,
  }) {
    if (iconData == null) {
      return ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            color: kWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            // color: kWhite,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      );
    }

    return ListTile(
      horizontalTitleGap: 5.0,
      leading: Icon(
        iconData,
        color: iconColor ?? kGrey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 10.sp,
          // color: kBlack,
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          fontSize: 20.sp,
          // color: kBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
