


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/services/platform_services.dart';
import '../../../../core/services/user_auth_helpers.dart';

class BuildLogoutWidget extends StatelessWidget {
  const BuildLogoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PlatformServices().showPlatformDialog(
          context,
          title: "Are you sure?",
          message: "You will be returned to the login screen.",
          onPressed: () {
            UserAuthHelpers().logOut(context);
          },
        );
      },
      child: Row(
        children: [
          SizedBox(
            width: 3.sp,
          ),
          Icon(
            Icons.power_settings_new_outlined,
            color: Colors.red.shade500,
          ),
          SizedBox(
            width: 3.sp,
          ),
          Text(
            "Log Out",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.red.shade500,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
