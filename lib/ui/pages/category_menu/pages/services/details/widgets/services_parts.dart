import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../shared/widgets/container_with_text.dart';
import '../../../../../../shared/widgets/custom_expansion_tile.dart';

class ServicesParts extends StatelessWidget {
  const ServicesParts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: "Parts",
      children: [
        ListTile(
          title: const Text("Tyre 1"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("123 - Tyre"),
              SizedBox(
                height: 3.sp,
              ),
              const Text("Fitted Runhours: 2310"),
            ],
          ),
          trailing: ContainerWithTextWidget(
            value: "1",
            fontSize: 10.sp,
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 2.sp),
          ),
        )
      ],
    );
  }
}