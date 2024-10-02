import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'required_text.dart';
import 'container_with_listtile.dart';

class RequiredTextWithContainerListTile extends StatelessWidget {
  final String value;
  final String label;
  final bool required;
  const RequiredTextWithContainerListTile({
    Key? key,
    required this.value,
    required this.label,
    required this.required,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredTextWidget(
          title: label,
          required: required,
        ),
        SizedBox(height: 3.sp),
        ContainerWithListTile(
          title: value,
        ),
      ],
    );
  }
}
