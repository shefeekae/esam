import 'package:app_filter_form/core/services/theme/theme_services.dart';
import 'package:flutter/material.dart';

class AlarmStatusServices {
//  =======================================================================================
// Get Status List
  List<Map<String, dynamic>> getStatusListData(
    BuildContext context, {
    required Map<String, dynamic>? data,
  }) {
    int activeAlarmsCount = data?["total"] ?? 0;

    int shutdownAlarmCount = data?["shutdown"] ?? 0;

    int criticalCount = data?["critical"] ?? 0;
    int highCount = data?["high"] ?? 0;

    int mediumCount = data?["medium"] ?? 0;
    int lowCount = data?["low"] ?? 0;
    int warningCount = data?["warning"] ?? 0;
    int unacknowledgedCount = data?["totalUnacknowledged"];

    return [
      {
        "title": "Active Alarms",
        "count": activeAlarmsCount,
        "colors": [Colors.red]
      },
      {
        "title": "Shutdown",
        "count": shutdownAlarmCount,
        "colors": [Colors.red],
      },
      {
        "title": "Critical",
        "count": criticalCount,
        "colors": [Colors.red]
      },
      {
        "title": "High",
        "count": highCount,
        "colors": [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).primaryColor,
        ],
      },
      {
        "title": "Medium",
        "count": mediumCount,
        "colors": [Colors.amber],
        "textColor": Colors.black
      },
      {
        "title": "Low",
        "count": lowCount,
        "colors": [Colors.amber],
        "textColor": Colors.black
      },
      {
        "title": "Warning",
        "count": warningCount,
        "colors": [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).primaryColor,
        ],
      },
      {
        "title": "Unacknowledged",
        "count": unacknowledgedCount,
        "colors": [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).primaryColor,
        ],
      },
    ];
  }

  String convertToK(int number) {
    if (number >= 1000) {
      double result = number / 1000;
      if (result == result.toInt()) {
        return '${result.toInt()}k';
      } else {
        return '${result.toStringAsFixed(1)}k';
      }
    } else {
      return number.toString();
    }
  }
}
