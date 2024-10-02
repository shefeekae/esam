

import 'package:flutter/material.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

class BuildVersionText extends StatelessWidget {
  const BuildVersionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "",
            style: TextStyle(
              fontSize: 10.sp,
            ),
          );
        }

        String version = snapshot.data?.version ?? '';

        return Text(
          "v$version",
          style: TextStyle(
            fontSize: 10.sp,
            color: kGrey,
          ),
        );
      },
    );
  }
}
