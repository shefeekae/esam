
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';

class DashboardListTile extends StatelessWidget {
  const DashboardListTile({
    super.key,
    required this.featureGroup,
    required this.feature,
    required this.permission,
    required this.onTap,
    required this.title,
    required this.leadingIcon,
  });

  final String featureGroup, feature, permission, title;
  final void Function() onTap;

  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return PermissionChecking(
      featureGroup: featureGroup,
      feature: feature,
      permission: permission,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.sp),
        child: ListTile(
          onTap: onTap,
          style: ListTileStyle.list,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
          tileColor: ThemeServices().getBgColor(context),
          leading: Container(
              padding: EdgeInsets.all(3.sp),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: Icon(
                leadingIcon,
                color: Colors.white,
              )),
          title: Text(
            title,
            style: TextStyle(fontSize: 12.sp),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
      ),
    );
  }
}