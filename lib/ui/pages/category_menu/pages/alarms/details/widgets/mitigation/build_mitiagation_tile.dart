import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_expansion_tile.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../../core/models/alarms/mitigation_model.dart';
import '../../../../../../../../utils/constants/colors.dart';
import '../../../../../../../shared/widgets/circle_avatar_with_text.dart';
import '../../../../../../../shared/widgets/container_with_text.dart';

class MitigationTileWidget extends StatelessWidget {
  const MitigationTileWidget({
    super.key,
    required this.step,
  });

  final Steps step;

  @override
  Widget build(BuildContext context) {
    bool done = step.executionStatus ?? false;

    List<SuccessItems> successItems = step.successItems ?? [];
    List<FailedItems> failedItems = step.failedItems ?? [];

    int successItemsCount = step.successItems?.length ?? 0;
    int failedItemsCount = step.failedItems?.length ?? 0;

    return GestureDetector(
      onTap: () {
        if (successItemsCount != 0 || failedItemsCount != 0) {
          showMitigationDialog(
            context,
            successItems: successItems,
            failedItems: failedItems,
            remark: step.remark ?? "",
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: ThemeServices().getContainerBgColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: ContainerWithTextWidget(
            value: done ? "Done" : "Not Done",
            bgColor: done ? Colors.green : Colors.red,
            borderRadius: 5,
            padding: EdgeInsets.symmetric(
              vertical: 3.sp,
              horizontal: 5.sp,
            ),
            fgColor: kWhite,
            fontSize: 8.sp,
          ),
          title: Text(
            step.title ?? step.name ?? "N/A",
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatarWithText(
                value: successItemsCount.toString(),
                bgColor: Colors.green.shade600,
                maxRadius: 8.sp,
              ),
              SizedBox(
                width: 5.sp,
              ),
              CircleAvatarWithText(
                value: failedItemsCount.toString(),
                bgColor: Colors.red.shade600,
                maxRadius: 8.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMitigationDialog(
    BuildContext context, {
    required String remark,
    required List<SuccessItems> successItems,
    required List<FailedItems> failedItems,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 70.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    "Remarks",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size(double.infinity, 50.sp)),
                    child: Text(
                      remark,
                      // overflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  buildSuccessFullAndFailedItemsExpansionTitle(
                    title: "${failedItems.length} Failed Items",
                    initialExpanded: true,
                    key: "failed",
                    list: failedItems
                        .map((e) => {
                              "title": e.data?.displayName,
                              "type": e.type,
                            })
                        .toList(),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  buildSuccessFullAndFailedItemsExpansionTitle(
                    title: "${successItems.length} Successfull Items",
                    key: "success",
                    list: successItems
                        .map((e) => {
                              "title": e.data?.displayName,
                              "type": e.type,
                            })
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// =============================================================================

  Widget buildSuccessFullAndFailedItemsExpansionTitle({
    required String title,
    bool initialExpanded = false,
    required String key,
    required List list,
  }) {
    return Builder(builder: (context) {
      return Visibility(
        visible: list.isNotEmpty,
        child: CustomExpansionTile(
          title: title,
          titleColor: key == "success" ? Colors.green : Colors.red,
          bgColor: ThemeServices().getContainerBgColor(context),
          initiallyExpanded: initialExpanded,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100.sp,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    list.length,
                    (index) {
                      var map = list[index];

                      String title = map['title'] ?? '';

                      return ListTile(
                        title: Text("${index + 1}) $title"),
                        trailing: ContainerWithTextWidget(
                          value: map['type'] ?? "",
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
