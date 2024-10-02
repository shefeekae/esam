import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:sizer/sizer.dart';

class IconHelpers {
  showEquipmentLeadingIcon(List<Points> points, String key) {
    bool? isNormal = points.every((e) => e.data == key);

    if (!isNormal) {
      bool? showIcon = points.any((e) {
        return e.data == key;
      });

      return showIcon;
    }
  }

  showHealthyLeadingIcon(List<Points>? points, String key) {
    bool isNormal = points!.every((e) => e.data == key || e.data == null);

    return isNormal;
  }

  Widget showAlarmLeadingIcon(String? point) {
    switch (point) {
      case "Fault Status":
        return const Tooltip(
          message: "Faulty",
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.info_outline,
            color: Colors.amber,
          ),
        );

      case "Device Disabled":
        return const Tooltip(
          message: "Device Disablde",
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.disabled_by_default_outlined,
            color: Colors.grey,
          ),
        );

      case "Head Missing":
        return const Tooltip(
          message: "Head Missing",
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.cable_outlined,
            color: Colors.red,
          ),
        );

      case "Fire Alarm":
        return const Tooltip(
          message: "Fire Alarm",
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.local_fire_department,
            color: Colors.red,
          ),
        );

      case "Dirty Status":
        return Tooltip(
          message: "Faulty Sensor",
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.dirty_lens,
            color: Colors.red.shade900,
          ),
        );

      default:
        return SizedBox(
          height: 18.sp,
        );
    }
  }
}
