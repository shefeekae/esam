import 'package:flutter/material.dart';
import 'package:graphql/src/core/query_result.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/alarm_dashboard.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/equipment_consoldation_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/chart/pie_chart_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllAlarmsCriticalityDistribution extends StatelessWidget {
  AllAlarmsCriticalityDistribution({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.entity,
    required this.dropdownType,
  });

  final int startDate;
  final int endDate;
  final Map<String, dynamic>? entity;
  final Level dropdownType;

  UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "domain": userData.domain,
      "facetField": "criticality",
      "startDate": startDate,
      "endDate": endDate,
      "entity": {
        "type": userData.tenant["type"],
        "data": {
          "domain": userData.tenant["domain"],
          "identifier": userData.tenant["identifier"],
        }
      }
    };

    if (entity != null) {
      data["entity"] = entity;
    }

    DateTime start = DateTime.fromMillisecondsSinceEpoch(startDate);
    DateTime end = DateTime.fromMillisecondsSinceEpoch(endDate);

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getTotalEventConsolidation,
          rereadPolicy: true,
          variables: {"data": data},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(
                enabled: true,
                child: buildLayout(result, [], start, end, context));
          }
          
           if (result.hasException) {
                  return GraphqlServices().handlingGraphqlExceptions(
                    result: result,
                    context: context,
                    refetch: refetch,
                  );
                }

          List<ChartData> chartData = [];

          var data = result.data ?? {};

         

          var responseMap =
              data["getTotalEventConsolidation"]?["responseMap"] ?? {};

          int lowCount = responseMap?["LOW"] ?? 0;
          int mediumCount = responseMap?["MEDIUM"] ?? 0;
          int criticalCount = responseMap?["CRITICAL"] ?? 0;
          int highCount = responseMap?["HIGH"] ?? 0;
          int warningCount = responseMap?["WARNING"] ?? 0;

          if (lowCount == 0 &&
              mediumCount == 0 &&
              criticalCount == 0 &&
              highCount == 0 &&
              warningCount == 0) {
            return const SizedBox();
          }

          chartData = [
            ChartData(
                label: "Low",
                value: lowCount.toDouble(),
                identifier: {"data": "LOW"}),
            ChartData(
                label: "Medium",
                value: mediumCount.toDouble(),
                identifier: {"data": "MEDIUM"}),
            ChartData(
                label: "Critical",
                value: criticalCount.toDouble(),
                identifier: {"data": "CRITICAL"}),
            ChartData(
                label: "High",
                value: highCount.toDouble(),
                identifier: {"data": "HIGH"}),
            ChartData(
                label: "Warning",
                value: warningCount.toDouble(),
                identifier: {"data": "WARNING"}),
          ];

          return buildLayout(result, chartData, start, end, context);
        });
  }

  Padding buildLayout(QueryResult<dynamic> result, List<ChartData> chartData,
      DateTime start, DateTime end, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "All Alarms - Criticality Distribution",
        titilePadding: EdgeInsets.all(8.sp),
        child: Skeletonizer(
          enabled: result.isLoading,
          child: PieChartWidget(
            chartData: chartData,
            onDoubleTap: (chartData) {
              String data = chartData.identifier?["data"];

              List<Map<String, dynamic>> filterValues = [
                {
                  "key": "criticalities",
                  "filterKey": "criticalities",
                  "identifier": [data],
                  "values": [
                    {
                      "name": chartData.label,
                      "data": data,
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
                  "identifier": entity?["data"]?["identifier"],
                  "values": [
                    {
                      "name": entity?["data"]?["name"] ?? "",
                      "data": entity?["data"]?["identifier"],
                    }
                  ]
                });
              }

              Navigator.of(context).pushNamed(EquipmentConsoldationScreen.id,
                  arguments: {"filterValues": filterValues});
            },
          ),
        ),
      ),
    );
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
