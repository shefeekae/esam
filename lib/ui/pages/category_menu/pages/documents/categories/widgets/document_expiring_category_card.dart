// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/list/documents_list_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../shared/widgets/circle_avatar_with_icon.dart';

class DocumentExpiringCategoryCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String value;
  final Color iconColor;
  const DocumentExpiringCategoryCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.value,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DocumentsListScreen.id, arguments: {
          "title": title,
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getBgColor(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatarWithIcon(
                  iconData: iconData,
                  iconSize: 18.sp,
                  maxRadius: 12.sp,
                  iconColor: iconColor,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.loose(Size(90.sp, 30.sp)),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
