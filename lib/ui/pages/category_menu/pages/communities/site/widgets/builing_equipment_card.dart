import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/models/asset/assets_list_model.dart';
import '../../../../../../../core/models/asset/get_asset_additional_data_model.dart';
import '../../../../../../../core/services/assets/assets_services.dart';
import '../../../../../../../core/services/site/building_summary_services.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../shared/widgets/container/background_container.dart';
import '../../../../../../shared/widgets/container_with_text.dart';
import '../../../../../../shared/widgets/location_path_widget.dart';

class BuildingEquipmentCard extends StatelessWidget {
  const BuildingEquipmentCard({required this.asset, super.key});

  final BuildingEquipmentsData asset;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(EquipmentDetailsScreen.id, arguments: {
          "domain": asset.domain,
          "type": asset.type,
          "identifier": asset.identifier,
          "displayName": asset.displayName,
        });
      },
      child: BgContainer(
          child: Padding(
        padding: EdgeInsets.all(7.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(asset),
            SizedBox(
              height: 5.sp,
            ),
            ContainerWithTextWidget(
              value: asset.type,
              fontSize: 8.sp,
            ),
            SizedBox(
              height: 5.sp,
            ),
            LocationPathWidget(
              value: asset.locationName,
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCriticalPoints(
                  context: context,
                  criticalPoints: asset.points,
                ),
                buildAlarmsCountWidget(
                    context: context, eventCount: asset.eventCount)
              ],
            )
          ],
        ),
      )),
    );
  }

  // ===========================================================================

  Row buildHeader(BuildingEquipmentsData asset) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 10.sp,
          color: AssetsServices().getOperationStatusColor(
            operationStatus: asset.operationStatus,
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Expanded(
          child: Text(
            asset.displayName,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ===============================================================================

  Widget buildAlarmsCountWidget({
    required BuildContext context,
    required EventCount? eventCount,
  }) {
    final List alarmsCountList = [
      {
        "title": "Critical",
        "count": eventCount?.critical ?? 0,
        "color": Colors.red.shade600,
      },
      {
        "title": "High",
        "count": eventCount?.high ?? 0,
        "color": Colors.orange.shade600,
      },
      {
        "title": "Medium",
        "count": eventCount?.mEDIUM ?? 0,
        "color": Colors.amber,
      },
      {
        "title": "Low",
        "count": eventCount?.lOW ?? 0,
        "color": Colors.amber.shade600,
      },
    ];

    return Container(
      width: 130.sp,
      decoration: BoxDecoration(
        color: ThemeServices().getContainerBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 12.sp,
                ),
                Text(
                  "Alarms",
                  style: TextStyle(fontSize: 7.sp),
                ),
              ],
            ),
            SizedBox(
              height: 3.sp,
            ),
            ...List.generate(alarmsCountList.length, (index) {
              Map<String, dynamic> map = alarmsCountList[index];

              String title = map['title'] ?? "";
              int count = map['count'] ?? 0;
              Color? bgColor = count == 0 ? Colors.grey : map['color'];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.sp),
                child: Row(
                  children: [
                    CircleAvatar(
                      minRadius: 8.sp,
                      backgroundColor:
                          bgColor ?? ThemeServices().getBgColor(context),
                      child: Text(
                        count.toString(),
                      ),
                    ),
                    SizedBox(
                      width: 4.sp,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 8.sp,
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  // ==========================================================================

  Widget buildCriticalPoints({
    required BuildContext context,
    required List<Points> criticalPoints,
  }) {
    return Container(
      width: 130.sp,
      decoration: BoxDecoration(
        color: ThemeServices().getContainerBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Visibility(
                  visible: criticalPoints.isNotEmpty,
                  child: Icon(
                    Icons.bolt_outlined,
                    size: 12.sp,
                  ),
                ),
                Text(
                  criticalPoints.isEmpty
                      ? "No Critical Points"
                      : "Critical Points",
                  style: TextStyle(fontSize: 7.sp),
                ),
              ],
            ),
            SizedBox(
              height: 3.sp,
            ),
            ...List.generate(criticalPoints.length, (index) {
              var point = criticalPoints[index];

              String data = point.data == null ? "" : point.data.toString();

              String unitSymbol =
                  point.unit == "unitless" ? "" : point.unitSymbol ?? "";

              String alarmData =
                  unitSymbol.isEmpty ? data : "$data $unitSymbol";

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.sp),
                child: BgContainer(
                  padding: EdgeInsets.all(3.sp),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        point.pointName ?? "",
                        style: TextStyle(
                          fontSize: 8.sp,
                        ),
                      )),
                      Text(
                        alarmData,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
