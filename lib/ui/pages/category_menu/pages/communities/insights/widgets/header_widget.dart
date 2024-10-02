import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/shared/widgets/container_with_text.dart';
import 'package:sizer/sizer.dart';

class CommunityHierarchyHeaderWidget extends StatelessWidget {
  const CommunityHierarchyHeaderWidget({
    super.key,
    required this.typeName,
    required this.displayName,
    required this.locationName,
  });

  final String? typeName;
  final String? locationName;
  final String? displayName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 40.sp,
          child: Center(
            child: Icon(
              Icons.apartment,
              size: 40.sp,
            ),
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName ?? "N/A",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              ContainerWithTextWidget(
                value: typeName ?? "",
                fontSize: 7.sp,
                padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 3.sp),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Visibility(
                visible: locationName?.isNotEmpty ?? false,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 8.sp,
                    ),
                    SizedBox(
                      width: 3.sp,
                    ),
                    Expanded(
                      child: Text(
                        locationName ?? "",
                        style: TextStyle(
                          fontSize: 8.sp,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
