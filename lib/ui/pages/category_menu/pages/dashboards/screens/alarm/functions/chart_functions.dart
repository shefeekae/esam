import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/alarm_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/alarm_lifetime_distirbution_chart_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/daily_distribution_chart_model.dart/day_data_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/daily_distribution_chart_model.dart/year_data_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/equipment_type_chart_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/equipment_consoldation_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartServices {
  /// Returns the list of chart series which need to render
  /// on the stacked area chart.
  List<StackedAreaSeries<StackedAreaDataModel, DateTime>>
      getAlarmLifetimeDistributionSeries(
          {required List<StackedAreaDataModel> chartData}) {
    return <StackedAreaSeries<StackedAreaDataModel, DateTime>>[
      StackedAreaSeries<StackedAreaDataModel, DateTime>(
        dataSource: chartData,
        xValueMapper: (StackedAreaDataModel data, _) => data.date,
        yValueMapper: (StackedAreaDataModel data, _) => data.active,
        name: 'Active',
      ),
      StackedAreaSeries<StackedAreaDataModel, DateTime>(
        dataSource: chartData,
        xValueMapper: (StackedAreaDataModel data, _) => data.date,
        yValueMapper: (StackedAreaDataModel data, _) => data.total,
        name: 'Total',
      ),
    ];
  }

  List<BarSeries<EquipmentTypeChartModel, String>> getEquipmentTypeChartSeries({
    required List<EquipmentTypeChartModel> chartData,
    required BuildContext context,
    required int startDate,
    required int endDate,
    required Map<String, dynamic>? entity,
    required Level dropdownType,
  }) {
    return <BarSeries<EquipmentTypeChartModel, String>>[
      BarSeries<EquipmentTypeChartModel, String>(
        onPointDoubleTap: (point) {
          String? type;
          String? title;

          if (point.pointIndex != null) {
            type = chartData[point.pointIndex!].type;

            title = chartData[point.pointIndex!].title;
          }

          // CartesianChartPoint type = pointInteractionDetails.dataPoints?[
          //         pointInteractionDetails.viewportPointIndex?.toInt() ?? 0]
          //     as CartesianChartPoint<dynamic>;

          // print(type.x);

          if (type != null && title != null) {
            goToEquipmentConsolidationFromEquipmentTypeCHart(
              context: context,
              title: title,
              type: type,
              endDate: endDate,
              startDate: startDate,
              entity: entity,
              dropdownType: dropdownType,
            );
          }
        },
        dataSource: chartData,
        yValueMapper: (EquipmentTypeChartModel data, _) => data.count,
        xValueMapper: (EquipmentTypeChartModel data, _) => data.title,
        name: 'Count',
      ),
    ];
  }

  goToEquipmentConsolidationFromEquipmentTypeCHart({
    required int startDate,
    required int endDate,
    required BuildContext context,
    required String type,
    required String title,
    required Map<String, dynamic>? entity,
    required Level dropdownType,
  }) {
    DateTime start = DateTime.fromMillisecondsSinceEpoch(startDate);
    DateTime end = DateTime.fromMillisecondsSinceEpoch(endDate);

    List<Map<String, dynamic>> filterValues = [
      {
        "key": "type",
        "filterKey": "type",
        "identifier": type,
        "values": [
          {
            "name": title,
            "data": type,
          }
        ]
      },
      {
        "key": "date",
        "filterKey": "date",
        "identifier": {"startDate": startDate, "endDate": endDate},
        "values": [
          {
            "name":
                "${DateFormat("dd MMM yyy").format(start)} - ${DateFormat("dd MMM yyy").format(end)}",
          }
        ]
      },
    ];

    if (entity != null) {
      filterValues.add({
        "key": getTemplateKey(dropdownType),
        "filterKey": "searchTagIds",
        "identifier": entity["data"]?["identifier"],
        "values": [
          {
            "name": entity["data"]?["name"] ?? "",
            "data": entity["data"]?["identifier"],
          }
        ]
      });
    }

    Navigator.of(context).pushNamed(
      EquipmentConsoldationScreen.id,
      arguments: {"filterValues": filterValues},
    );
  }

  List<Map<String, dynamic>> addDataToList(
      {required Duration diff, required List results}) {
    List<Map<String, dynamic>> list = [];

    if (diff.inDays >= 364) {
      for (var element in results) {
        int year = element['field']['value'];
        int count = element['field']['count'];

        bool contains = list.any((e) => e['title'] == year.toString());

        DateTime yearDate = DateTime(year);

        if (!contains) {
          list.add({
            "date": yearDate,
            "count": count,
          });
        }
      }
      list.sort((a, b) => a["date"].compareTo(b["date"]));
    }
    if (diff.inDays < 364 && diff.inDays > 30) {
      for (var result in results) {
        int year = result["field"]["value"];
        List<dynamic> pivots = result['pivots'];

        for (var element in pivots) {
          int month = element['field']['value'];
          int count = element['field']['count'];

          DateTime date = DateTime(year, month);

          list.add({
            "date": date,
            "count": count,
          });
        }
      }
      list.sort((a, b) => a["date"].compareTo(b["date"]));
    }
    if (diff.inDays <= 30) {
      list = processResults(results);

      list.sort((a, b) => a["date"].compareTo(b["date"]));
    }

    return list;
  }

  List<Map<String, dynamic>> processResults(List<dynamic> results) {
    Map<DateTime, DateCount> dateCountsMap = {};

    for (var result in results) {
      int year = result["field"]["value"];

      for (var pivot1 in result["pivots"]) {
        int month = pivot1["field"]["value"];

        for (var pivot2 in pivot1["pivots"]) {
          int day = pivot2["field"]["value"];
          int criticalCount = getCriticalCount(pivot2);
          int resolvedCount = getResolvedCount(pivot2);

          DateTime currentDate = DateTime(year, month, day);
          if (!dateCountsMap.containsKey(currentDate)) {
            dateCountsMap[currentDate] = DateCount(
              date: currentDate,
              totalCount: pivot2["field"]["count"],
              criticalCount: criticalCount,
              resolvedCount: resolvedCount,
            );
          } else {
            // Update criticalCount and resolvedCount for the current date
            dateCountsMap[currentDate]!.criticalCount += criticalCount;
            dateCountsMap[currentDate]!.resolvedCount += resolvedCount;
          }
        }
      }
    }

    return dateCountsMap.values.map((dateCount) => dateCount.toJson()).toList();
  }

  int getCriticalCount(Map<String, dynamic> pivot) {
    for (var subPivot in pivot["pivots"]) {
      if (subPivot["field"]["value"] == "CRITICAL") {
        return subPivot["field"]["count"];
      }
    }
    return 0;
  }

  int getResolvedCount(Map<String, dynamic> pivot) {
    for (var subPivot in pivot["pivots"]) {
      if (subPivot["field"]["value"] == true) {
        return subPivot["field"]["count"];
      }
    }
    return 0;
  }

  buildColumnSeries(
      {required Duration diff,
      required List<DailyDistributionYearDataModel> yearChartData,
      required List<DailyDistributionDayDataModel> dayChartData,
      required Function(ChartPointDetails chartData, String name)
          onDoubleTap}) {
    if (diff.inDays > 30) {
      return [
        ColumnSeries<DailyDistributionYearDataModel, DateTime>(
          dataSource: yearChartData,
          xValueMapper: (DailyDistributionYearDataModel data, _) =>
              data.dateTime,
          yValueMapper: (DailyDistributionYearDataModel data, _) => data.count,
          name: "Total",
          onPointDoubleTap: (pointInteractionDetails) {
            onDoubleTap(pointInteractionDetails, "Total");
          },
        )
      ];
    } else if (diff.inDays <= 30) {
      return [
        ColumnSeries<DailyDistributionDayDataModel, DateTime>(
          dataSource: dayChartData,
          xValueMapper: (DailyDistributionDayDataModel data, _) =>
              data.dateTime,
          yValueMapper: (DailyDistributionDayDataModel data, _) =>
              data.totalCount,
          name: "Total",
          color: Colors.blue,
          onPointDoubleTap: (pointInteractionDetails) {

            onDoubleTap(pointInteractionDetails, "Total");
          },
        ),
        ColumnSeries<DailyDistributionDayDataModel, DateTime>(
          dataSource: dayChartData,
          xValueMapper: (DailyDistributionDayDataModel data, _) =>
              data.dateTime,
          yValueMapper: (DailyDistributionDayDataModel data, _) =>
              data.resolvedCount,
          name: "Resolved",
          color: Colors.green,
          onPointDoubleTap: (pointInteractionDetails) {
            onDoubleTap(pointInteractionDetails, "Resolved");
          },
        ),
        ColumnSeries<DailyDistributionDayDataModel, DateTime>(
          dataSource: dayChartData,
          xValueMapper: (DailyDistributionDayDataModel data, _) =>
              data.dateTime,
          yValueMapper: (DailyDistributionDayDataModel data, _) =>
              data.criticalCount,
          name: "Critical",
          color: Colors.red,
          onPointDoubleTap: (pointInteractionDetails) {
            onDoubleTap(pointInteractionDetails, "Critical");
          },
        ),
      ];
    }
  }

  getTemplateKey(Level dropdownType) {
    switch (dropdownType) {
      case Level.community:
        return "community";
      case Level.subCommunity:
        return "subCommunity";
      case Level.site:
        return "building";
      case Level.space:
        return "space";

      default:
        return "community";
    }
  }
}

class DateCount {
  DateTime date;
  int totalCount;
  int criticalCount;
  int resolvedCount;

  DateCount({
    required this.date,
    required this.totalCount,
    required this.criticalCount,
    required this.resolvedCount,
  });

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "totalCount": totalCount,
      "criticalCount": criticalCount,
      "resolvedCount": resolvedCount,
    };
  }
}
