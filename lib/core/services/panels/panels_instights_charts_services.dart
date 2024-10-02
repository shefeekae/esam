import 'package:flutter/material.dart';

import '../../../ui/pages/category_menu/pages/alarms/list/alarms_list.dart';

class PanelsInsightsServices {
  void goToAlarmPage(BuildContext context, {required String title}) {
    bool isFireAlarm = title == "Fire Alarm";

    Navigator.of(context).pushNamed(
      AlarmsListScreen.id,
      arguments: {
        "filterValues": isFireAlarm
            ? [
                {
                  "key": "category",
                  "filterKey": "groups",
                  "identifier": ["FIREALARM"],
                  "values": [
                    {
                      "name": title,
                      "data": "FIREALARM",
                    },
                  ],
                }
              ]
            : null,
        "categories": isFireAlarm ? ["FIREALARM"] : null,
        "searchValue": isFireAlarm ? "" : title,
      },
    );
  }

  // ===========================================================================

  Color getAlarmTypeColor(String label) {
    switch (label) {
      case "Fire Alarm":
        return Colors.red;
      case "Dirty":
        return Colors.amber;
      case "Disabled":
        return Colors.grey;
      case "Common Fault":
        return Colors.orange.shade700;
      case "Healthy":
        return Colors.green;
      case "Head Missing":
        return Colors.blue;
      default:
        // Default color if the label doesn't match any case
        return Colors.grey.shade50;
    }
  }

// ===============================================================================

  Map<String, dynamic> getFirePanelAgeData() {
    DateTime now = DateTime.now();

    var todayStartDate = DateTime(now.year, now.month, now.day);
    var todayEndDate =
        todayStartDate.add(const Duration(hours: 23, minutes: 59, seconds: 59));

    var yesterDayStartDate = todayStartDate.subtract(const Duration(days: 1));
    var yesterDayEndDate = yesterDayStartDate
        .add(const Duration(hours: 23, minutes: 59, seconds: 59));

    var twoToFiveDaysStartDate =
        todayStartDate.subtract(const Duration(days: 5));
    var twoToFiveDaysEndDate = twoToFiveDaysStartDate
        .add(const Duration(days: 3, hours: 23, minutes: 59, seconds: 59));

    var sixToTenDaysStartDate =
        todayStartDate.subtract(const Duration(days: 10));
    var sixToTenDaysEndDate = sixToTenDaysStartDate
        .add(const Duration(days: 4, hours: 23, minutes: 59, seconds: 59));

    var elevenTo30DaysStartDate =
        todayStartDate.subtract(const Duration(days: 30));
    var elevenTo30DaysEndDate = elevenTo30DaysStartDate
        .add(const Duration(days: 19, hours: 23, minutes: 59, seconds: 59));

    var thirtyDaysPlusStartDate =
        DateTime(todayStartDate.year - 5, todayStartDate.month, 1);
    var thirtyDaysPlusEndDate = elevenTo30DaysStartDate
        .subtract(const Duration(days: 1, hours: 23, minutes: 59, seconds: 59));

    return {
      "Today": {
        "startDate": todayStartDate.millisecondsSinceEpoch,
        "endDate": todayEndDate.millisecondsSinceEpoch
      },
      "Yesterday": {
        "startDate": yesterDayStartDate.millisecondsSinceEpoch,
        "endDate": yesterDayEndDate.millisecondsSinceEpoch
      },
      "2-5 Days": {
        "startDate": twoToFiveDaysStartDate.millisecondsSinceEpoch,
        "endDate": twoToFiveDaysEndDate.millisecondsSinceEpoch
      },
      "6-10 Days": {
        "startDate": sixToTenDaysStartDate.millisecondsSinceEpoch,
        "endDate": sixToTenDaysEndDate.millisecondsSinceEpoch
      },
      "11-30 Days": {
        "startDate": elevenTo30DaysStartDate.millisecondsSinceEpoch,
        "endDate": elevenTo30DaysEndDate.millisecondsSinceEpoch
      },
      "31+ Days": {
        "startDate": thirtyDaysPlusStartDate.millisecondsSinceEpoch,
        "endDate": thirtyDaysPlusEndDate.millisecondsSinceEpoch
      }
    };
  }
}
