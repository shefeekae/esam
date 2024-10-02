import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/alarms/suspect_points_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import '../../models/alarms/alarms_details_model.dart';
import 'package:nectar_assets/core/models/alarms/live_data_model.dart';

class AlarmsDetailsServices {
//  ================================================================
// Alarm acknowledget

  void acknowledgeAlarm(
    BuildContext context, {
    required String eventId,
    required bool? isAcknowledged,
  }) {
    if (isAcknowledged == null) {
      return;
    }

    if (!isAcknowledged) {
      bool hasPermission = UserPermissionServices().checkingPermission(
        featureGroup: "alarmManagement",
        feature: "list",
        permission: "acknowledge",
      );

      if (!hasPermission) {
        return;
      }

      GraphqlServices().performMutation(
          context: context,
          query: AlarmsSchema.acknowledgeAlarms,
          variables: {
            "data": [
              {
                "eventId": eventId,
              }
            ]
          }).then((value) {});
    }
  }

  // =================================
  // Returning the suspectpointTabledata list

  List<SuspectPointsTableDataModel> getSuspectPointsTableData(
      {required List<Point> points, required List suspecPoint}) {
    return suspecPoint.map((e) {
      String alarmData = "N/A";

      // Point? point = points.singleWhereOrNull(
      //   (element) => element.pointName == e['pointName'],
      // );

      if (e != null) {
        String data = e['data'] == null ? "" : e['data'].toString();
        String unitSymbol =
            e['unit'] == "unitless" ? "" : e['unitSymbol'] ?? "";

        alarmData = unitSymbol.isEmpty ? data : "$data $unitSymbol";
      }

      e['alarmData'] = alarmData;

      if (e['unit'] != "unitless") {
        e['data'] = "${e['data']} ${e['unitSymbol']}";
      }

      return SuspectPointsTableDataModel.fromJson(e);
    }).toList();
  }

// =============================================================================

  List<Map<String, dynamic>> getAlarmAssetLiveTableData({
    required List<Points> liveData,
    required List suspectPoints,
  }) {
    // print("suspect points array length: ${suspectPoints.length}");

    liveData.sort(
      (a, b) {
        String aPointName = a.pointName ?? "";

        String bPointName = b.pointName ?? "";

        return aPointName.compareTo(bPointName);
      },
    );

    for (var element in suspectPoints) {
      bool contains = liveData.any((e) => e.pointName == element['pointName']);

      if (contains) {
        liveData.removeWhere((e) => e.pointName == element['pointName']);
        liveData.insert(0, Points.fromJson(element));
      }
    }

    return List.generate(
      liveData.length,
      (index) {
        var point = liveData[index];

        String data = point.data ?? "";

        if (point.unit != "unitless") {
          data = "$data ${point.unit}";
        }

        return {
          "Point Name": point.pointName,
          "Live": data,
          "Status": point.status?.toUpperCase(),
        };
      },
    );
  }
}
