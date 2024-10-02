import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/container_with_icon.dart';

class ContainerWithIconAndText extends StatelessWidget {
  const ContainerWithIconAndText({
    super.key,
    required this.iconData,
    required this.value,
    this.bgColor,
  });

  final IconData iconData;
  final String value;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ContainerWithIcon(
          iconData: iconData,
          bgColor: bgColor ?? kGrey,
        ),
        SizedBox(
          width: 10.sp,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
