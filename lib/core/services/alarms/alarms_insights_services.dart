

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import '../../../ui/shared/functions/date_helpers.dart';

class AlarmsInsightsServices {
   // ============================================================================================

  getCriticalityData(String data) {
    switch (data) {
      case "Critical":
        return {
          "label": "Critical",
          "data": "CRITICAL",
        };

      case "Low":
        return {
          "label": "Low",
          "data": "LOW",
        };

      case "Medium":
        return {
          "label": "Medium",
          "data": "MEDIUM",
        };

      default:
    }
  }

  // =================================================================================

void  barChartNavigationHandling(BuildContext context,{
    required String label,
    required String chartName,
  }) {
    bool isCriticalities = ["Critical", "Low", "Medium", "High"]
            .any((element) => element == label);

        bool isCategories =
            ["Shutdown", "MLAlarms"].any((element) => element == label);

        bool isStatus =
            ["Persistent", "ActionRequired"].any((element) => element == label);

        Map<String, dynamic> dateData = {};

        if (chartName == "Current days active alarms") {
          DateTimeRange dateTimeRange = DateHelpers().getTodayDateRange();

          String start =
              DateFormat("MMM d yyyy").add_jms().format(dateTimeRange.start);
          String end =
              DateFormat("MMM d yyyy").add_jms().format(dateTimeRange.end);

          dateData = {
            "key": "dateRange",
            "filterKey": "date",
            "identifier": {
              "startDate": dateTimeRange.start.millisecondsSinceEpoch,
              "endDate": dateTimeRange.end.millisecondsSinceEpoch,
            },
            "values": [
              {
                "name": "$start - $end",
                "data": {
                  "start": dateTimeRange.start.millisecondsSinceEpoch,
                  "end": dateTimeRange.end.millisecondsSinceEpoch,
                },
              }
            ]
          };
        }

        if (isCriticalities) {
          Map<String, dynamic> map = getCriticalityData(label) ?? {};

          String name = map['label'] ?? "";
          String data = map['data'] ?? "";

          Navigator.of(context).pushNamed(
            AlarmsListScreen.id,
            arguments: {
              "filterValues": [
                {
                  "key": "criticality",
                  "filterKey": "criticalities",
                  "identifier": [data],
                  "values": [
                    {
                      "name": name,
                      "data": data,
                    }
                  ]
                },
                dateData,
              ],
            },
          );
        } else if (label == "WithoutWorkOrder") {
          String data = "EXCLUDE";

          Navigator.of(context).pushNamed(
            AlarmsListScreen.id,
            arguments: {
              "filterValues": [
                {
                  "key": "workOrders",
                  "filterKey": "workOrderStatus",
                  "identifier": data,
                  "values": [
                    {
                      "name": "Work order not generated alarms",
                      "data": data,
                    }
                  ]
                },
                dateData,
              ],
            },
          );
        } else if (isCategories) {
          dynamic data;
          List values = [];

          if (label == "Shutdown") {
            data = ["SHUTDOWN"];
            values = [
              {
                "name": "Shutdown",
                "data": "SHUTDOWN",
              }
            ];
          } else if (label == "MLAlarms") {
            data = ["PREVENTIVE", "PREDICTIVE"];
            values = [
              {
                "name": "Preventive",
                "data": "PREVENTIVE",
              },
              {
                "name": "Predective",
                "data": "PREDICTIVE",
              },
            ];
          }

          Navigator.of(context).pushNamed(
            AlarmsListScreen.id,
            arguments: {
              "filterValues": [
                {
                  "key": "category",
                  "filterKey": "groups",
                  "identifier": data,
                  "values": values,
                },
                dateData,
              ],
            },
          );
        } else if (isStatus) {
          String data = "";

          Map<String, dynamic> map = {};

          if (label == "Persistent") {
            data = "recurring";
            map = {
              "name": "Persistent",
              "aliasName": "other_status",
              "data": "recurring",
            };
          } else if (label == "ActionRequired") {
            data = "recurring";
            map = {
              "name": "Action Required",
              "aliasName": "other_status",
              "data": "actionRequired",
            };
          }

          Navigator.of(context).pushNamed(
            AlarmsListScreen.id,
            arguments: {
              "filterValues": [
                {
                  "key": "status",
                  "filterKey": "status",
                  "identifier": [
                    "active",
                    data,
                  ],
                  "values": [
                    {
                      "name": "Active",
                      "aliasName": "active_resolved",
                      "data": "active",
                    },
                    map,
                  ]
                },
                dateData,
              ],
            },
          );
        }
  }
  
}