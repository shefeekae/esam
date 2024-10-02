

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/circle_avatar_with_icon.dart';
import '../../../../../../shared/widgets/custom_expansion_tile.dart';

class ServicesChecklists extends StatelessWidget {
  const ServicesChecklists({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: "Checklists",
      children: [
        ListTile(
          leading: CircleAvatarWithIcon(
            maxRadius: 11.sp,
            iconData: Icons.done,
            bgColor: Colors.green,
            iconColor: kWhite,
            iconSize: 15.sp,
          ),
          title: Text("Ac Belt Change"),
          subtitle: Text("ac belt change"),
        )
      ],
    );
  }
}
