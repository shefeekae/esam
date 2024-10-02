import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';

import '../images/no_access_image_widget.dart';

class PermissionChecking extends StatelessWidget {
  const PermissionChecking({
    required this.child,
    required this.featureGroup,
    this.feature = "",
    this.permission = "",
    this.showNoAccessWidget = false,
    this.paddingTop = 0,
    super.key,
  });

  final String featureGroup, feature, permission;
  final Widget child;
  final bool showNoAccessWidget;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    bool hasPermission = UserPermissionServices().checkingPermission(
      featureGroup: featureGroup,
      feature: feature,
      permission: permission,
    );

    if (!hasPermission && showNoAccessWidget) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: const NoAccessImageWidget(),
        ),
      );
    }

    return Visibility(
      visible: hasPermission,
      child: child,
    );
  }
}
