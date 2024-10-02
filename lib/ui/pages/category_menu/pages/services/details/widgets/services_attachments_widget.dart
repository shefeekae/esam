


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../shared/widgets/custom_expansion_tile.dart';

class ServicesAttachments extends StatelessWidget {
  const ServicesAttachments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: "Attachments",
      children: [
        SizedBox(
          height: 60.sp,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.amber,
                ),
                height: 60.sp,
                width: 70.sp,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 5.sp,
              );
            },
            itemCount: 5,
          ),
        )
      ],
    );
  }
}
