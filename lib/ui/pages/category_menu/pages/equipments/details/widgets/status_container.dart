import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/asset/asset_info_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:sizer/sizer.dart';

class StatusCountContainer extends StatelessWidget {
  const StatusCountContainer({
    super.key,
    required this.title,
    required this.value,
    required this.assets,
    required this.type,
    required this.alarmKey,
  });
  final String alarmKey;
  final String value;
  final String title;
  final AssetData assets;
  final String? type;

  @override
  Widget build(BuildContext context) {
    Color bgColor = getBgColor(alarmKey) ?? Theme.of(context).primaryColor;
    Color fgColor = ThemeServices().getFgColor(bgColor);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AlarmsListScreen.id, arguments: {
          "filterValues": getArguments(
            type: type,
            assets: assets,
            alarmKey: alarmKey,
          )
        });
      },
      child: Card(
        child: Container(
          width: 50.sp,
          height: 62.sp,
          padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 8.sp,
                  color: fgColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: fgColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color? getBgColor(String key) {
    switch (key) {
      case "critical":
      case "shutdown":
        return Colors.red.shade500;

      case "low":
        return Colors.amber;
    }
    return null;
  }

  List<Map<String, dynamic>> getArguments({
    required String? type,
    required AssetData assets,
    required String alarmKey,
  }) {
    var assetFilterValueMap = {
      "key": "assets",
      "filterKey": "assets",
      "identifier": [
        {
          "type": type,
          "data": {
            "domain": assets.domain,
            "identifier": assets.identifier,
            "displayName": assets.displayName,
          }
        }
      ],
      "values": [
        {
          "name": assets.displayName,
          "data": {
            "type": type,
            "data": {
              "domain": assets.domain,
              "identifier": assets.identifier,
              "displayName": assets.displayName,
            }
          },
        }
      ]
    };

    switch (alarmKey) {
      case "critical":
        return [
          assetFilterValueMap,
          {
            "key": "criticality",
            "filterKey": "criticalities",
            "identifier": "CRITICAL",
            "values": [
              {
                "name": "Critical",
                "data": "CRITICAL",
              }
            ]
          }
        ];

      case "total":
        return [
          assetFilterValueMap,
        ];

      case "shutdown":
        return [
          assetFilterValueMap,
          {
            "key": "category",
            "filterKey": "groups",
            "identifier": ["SHUTDOWN"],
            "values": [
              {
                "name": "Shutdown",
                "data": "SHUTDOWN",
              }
            ]
          }
        ];

      case "low":
        return [
          assetFilterValueMap,
          {
            "key": "criticality",
            "filterKey": "criticalities",
            "identifier": "LOW",
            "values": [
              {
                "name": "Low",
                "data": "LOW",
              }
            ]
          }
        ];

      default:
        return [
          assetFilterValueMap,
        ];
    }
  }
}
