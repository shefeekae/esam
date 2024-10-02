import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/functions/chart_functions.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/daily_distribution_chart_model.dart/day_data_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/daily_distribution_chart_model.dart/year_data_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/consoldation/equipment_consoldation_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class AllAlarmsDailyDistributionWidget extends StatelessWidget {
  AllAlarmsDailyDistributionWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.entity,
    required this.dropdownType,
  });

  final int startDate;
  final int endDate;
  final Level dropdownType;
  final UserDataSingleton userData = UserDataSingleton();
  final Map<String, dynamic>? entity;

  @override
  Widget build(BuildContext context) {
    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startDate);
    DateTime endtDateTime = DateTime.fromMillisecondsSinceEpoch(endDate);

    Duration diff = endtDateTime.difference(startDateTime);

    // DateTime start = DateTime.fromMillisecondsSinceEpoch(startDate);
    // DateTime end = DateTime.fromMillisecondsSinceEpoch(endDate);

    Map<String, dynamic> data = {
      "domain": userData.domain,
      "facetPivots": [
        "criticality",
        "resolved",
      ],
      "startDate": startDate,
      "endDate": endDate,
      "entities": [
        {
          "type": userData.tenant['type'],
          "data": {
            "domain": userData.tenant['domain'],
            "identifier": userData.tenant['identifier'],
          }
        }
      ]
    };

    if (entity != null) {
      data["entities"] = [entity];
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getAlarmConsolidationDataByDate,
          rereadPolicy: true,
          variables: {"data": data},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(
                enabled: true,
                child: buildLayout(
                  context,
                  diff,
                  [],
                  [],
                ));
          }

          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List<DailyDistributionYearDataModel> yearChartData = [];
          List<DailyDistributionDayDataModel> dayChartData = [];

          var data = result.data ?? {};

          List<dynamic> results =
              data["getAlarmConsolidationDataByDate"]?["results"] ?? [];

          List<Map<String, dynamic>> list =
              ChartServices().addDataToList(diff: diff, results: results);

          if (list.isEmpty) {
            return const SizedBox();
          }

          if (diff.inDays > 30) {
            yearChartData = List.generate(
              list.length,
              (index) {
                DateTime year = list[index]["date"];
                int totalCount = list[index]["count"];

                return DailyDistributionYearDataModel(
                    dateTime: year, count: totalCount);
              },
            );
          } else if (diff.inDays < 30) {
            dayChartData = List.generate(list.length, (index) {
              DateTime date = list[index]["date"];
              int totalCount = list[index]["totalCount"];
              int criticalCount = list[index]["criticalCount"];
              int resolvedCount = list[index]["resolvedCount"];

              return DailyDistributionDayDataModel(
                  dateTime: date,
                  totalCount: totalCount,
                  criticalCount: criticalCount,
                  resolvedCount: resolvedCount);
            });
          }

          return buildLayout(
            context,
            diff,
            yearChartData,
            dayChartData,
          );
        });
  }

  Padding buildLayout(
    BuildContext context,
    Duration diff,
    List<DailyDistributionYearDataModel> yearChartData,
    List<DailyDistributionDayDataModel> dayChartData,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "All Alarms - Daily Distribution",
        titilePadding: EdgeInsets.all(8.sp),
        child: SfCartesianChart(
          backgroundColor: ThemeServices().getBgColor(context),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            canShowMarker: true,
            activationMode: ActivationMode.singleTap,
            shouldAlwaysShow: true,
            shared: true,
          ),
          plotAreaBorderWidth: 0,
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enableDoubleTapZooming: true,
            enablePanning: true,
          ),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom,
          ),
          primaryXAxis: DateTimeCategoryAxis(
            dateFormat: getDateFormat(diff),
          ),
          primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
          series: ChartServices().buildColumnSeries(
            diff: diff,
            yearChartData: yearChartData,
            dayChartData: dayChartData,
            onDoubleTap: (point, name) {
              List<Map<String, dynamic>> filterValues = [
                {
                  "key": "date",
                  "filterKey": "date",
                  "identifier": {"startDate": startDate, "endDate": endDate},
                  "values": [
                    {
                      "name":
                          "${DateFormat("dd MMM yyy").format(DateTime.fromMillisecondsSinceEpoch(startDate))} - ${DateFormat("dd MMM yyy").format(DateTime.fromMillisecondsSinceEpoch(endDate))}",
                    }
                  ]
                },
              ];

              if (entity != null) {
                filterValues.add({
                  "key": getTemplateKey(dropdownType),
                  "filterKey": "searchTagIds",
                  "identifier": entity,
                  "values": [
                    {
                      "name": entity?["data"]?["name"] ?? "",
                      "data": entity,
                    }
                  ]
                });
              }

              if (name == "Critical") {
                filterValues.add(
                  {
                    "key": "criticalities",
                    "filterKey": "criticalities",
                    "identifier": ["CRITICAL"],
                    "values": [
                      {
                        "name": "Critical",
                        "data": "CRITICAL",
                      }
                    ]
                  },
                );
              }

              Navigator.of(context).pushNamed(
                EquipmentConsoldationScreen.id,
                arguments: {"filterValues": filterValues},
              );
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

  getDateFormat(Duration diff) {
    if (diff.inDays >= 364) {
      return DateFormat.y();
    } else if (diff.inDays < 364 && diff.inDays > 30) {
      return DateFormat.yMMM();
    } else {
      return DateFormat.yMMMd();
    }
  }
}
