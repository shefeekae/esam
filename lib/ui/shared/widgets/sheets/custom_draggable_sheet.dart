import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class CustomDraggableScroallableSheet extends StatelessWidget {
  const CustomDraggableScroallableSheet({
    super.key,
    required this.builder,
    this.minChildSize = 0.3,
  });

  final Widget Function(BuildContext context, ScrollController controller)
      builder;
  final double minChildSize;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: minChildSize,
      minChildSize: minChildSize,
      maxChildSize: 0.88,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Brightness.dark == Theme.of(context).brightness
                ? Theme.of(context).scaffoldBackgroundColor
                : kWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 5.sp,
                width: 10.w,
                decoration: BoxDecoration(
                  color: kGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(child: builder(context, controller)),
            ],
          ),
        );
      },
    );
  }
}
