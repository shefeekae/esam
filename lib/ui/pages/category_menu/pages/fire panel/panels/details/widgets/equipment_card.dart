import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/functions/asset_path.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/functions/show_icon.dart';
import 'package:sizer/sizer.dart';

class PanelEquipmentCard extends StatelessWidget {
  const PanelEquipmentCard({
    super.key,
    required this.asset,
  });

  final Assets asset;

  @override
  Widget build(BuildContext context) {
    String locationPath = asset.path == null
        ? "Not available"
        : getAssetShortPath(asset.path!.map((e) => e.toJson()).toList());

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
      child: Container(
          padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
              color: ThemeServices().getBgColor(context),
              borderRadius: BorderRadius.circular(5.sp)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                asset.displayName ?? "N/A",
                style: TextStyle(fontSize: 12.sp),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: asset.typeName?.isNotEmpty ?? false,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.sp, vertical: 2.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        asset.typeName ?? "",
                        style: TextStyle(
                            color: ThemeServices().getPrimaryFgColor(context),
                            fontSize: 10.sp),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: IconHelpers().showEquipmentLeadingIcon(
                                asset.points ?? [], "Fault") ??
                            false,
                        child: const Tooltip(
                          message: "Faulty Sensor",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: IconHelpers().showEquipmentLeadingIcon(
                                asset.points ?? [], "Disabled") ??
                            false,
                        child: const Tooltip(
                          message: "Disabled Sensor",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.disabled_by_default_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: IconHelpers().showEquipmentLeadingIcon(
                                asset.points ?? [], "Missing") ??
                            false,
                        child: const Tooltip(
                          message: "Missing Sensor",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.cable_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: IconHelpers().showEquipmentLeadingIcon(
                                asset.points ?? [], "Dirty") ??
                            false,
                        child: Tooltip(
                          message: "Dirty Sensor",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.dirty_lens,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: IconHelpers().showHealthyLeadingIcon(
                                asset.points, "Normal") ??
                            false,
                        child: const Tooltip(
                          message: "Healthy Sensor",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: IconHelpers().showEquipmentLeadingIcon(
                              asset.points ?? [],
                              "Alarm",
                            ) ??
                            false,
                        child: const Tooltip(
                          message: "Alarm",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Icon(
                            Icons.local_fire_department,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.sp,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 10.sp,
                  ),
                  Expanded(
                    child: Text(
                      locationPath,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
