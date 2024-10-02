import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/schemas/dashboard_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/panels/panels_instights_charts_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/model/active_alarm_aging_distribution_model.dart';
import 'package:nectar_assets/ui/shared/functions/reorder_map.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActiveAlarmsAgingDistributionWidget extends StatelessWidget {
  ActiveAlarmsAgingDistributionWidget({
    super.key,
    required this.identifier,
    required this.dropdownType,
    required this.entity,
    required this.startDate,
    required this.endDate,
  });

  final String? identifier;
  final Level dropdownType;
  final Map<String, dynamic>? entity;
  final int startDate;
  final int endDate;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "ages": PanelsInsightsServices().getFirePanelAgeData(),
      "filter": {
        "domain": userData.domain,
        "status": ["active"],
        "searchTagIds": [userData.domain]
      }
    };

    if (identifier != null) {
      data["filter"]["searchTagIds"] = [identifier];
    }

    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          query: DashboardSchema.getAlarmAgeingData,
          rereadPolicy: true,
          variables: {"data": data},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Skeletonizer(child: buildLayout(context, []));
          }

          if (result.hasException) {
            return GraphqlServices().handlingGraphqlExceptions(
              result: result,
              context: context,
              refetch: refetch,
            );
          }

          List<ActiveAlarmAgingBarChartModel> chartData = [];

          Map<String, dynamic> data = result.data?["getAlarmAgeingData"] ?? {};

          Map<String, dynamic> reorderedData = reorderMap(
            keyOrder: [
              'Today',
              'Yesterday',
              '2-5 Days',
              '6-10 Days',
              '11-30 Days',
              '31+ Days',
            ],
            myMap: data,
          );

          reorderedData.forEach((key, value) {
            String title = key;

            int shutdown = value["shutdown"] ?? 0;
            int critical = value["critical"] ?? 0;
            int total = value["total"] ?? 0;

            chartData.add(ActiveAlarmAgingBarChartModel(
              shutdown: shutdown,
              critical: critical,
              total: total,
              title: title,
              entity: entity,
            ));
          });

          bool isEmpty = chartData.every((element) =>
              element.critical == 0 &&
              element.shutdown == 0 &&
              element.total == 0);

          if (isEmpty) {
            return const SizedBox();
          }

          return buildLayout(context, chartData);
        });
  }

  Padding buildLayout(
      BuildContext context, List<ActiveAlarmAgingBarChartModel> chartData) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: "Active Alarms Ageing Distribution",
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
            enablePanning: true,
          ),
          // title: ChartTitle(text: 'Sales comparision of fruits in a shop'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom,
          ),
          primaryXAxis: CategoryAxis(),

          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
          ),
          series: [
            buildColumnSeries(
              context,
              name: "Shutdown",
              color: Colors.red,
              yValueMapper: (data, p1) => data.shutdown,
              chartData: chartData,
            ),
            buildColumnSeries(
              context,
              name: "Critical",
              color: Colors.amber,
              yValueMapper: (data, p1) => data.critical,
              chartData: chartData,
            ),
            buildColumnSeries(
              context,
              name: "Total",
              color: Colors.grey,
              yValueMapper: (data, p1) => data.total,
              chartData: chartData,
            ),
          ],
        ),
      ),
    );
  }

  ColumnSeries<ActiveAlarmAgingBarChartModel, String> buildColumnSeries(
      BuildContext context,
      {required String name,
      required Color color,
      required num? Function(ActiveAlarmAgingBarChartModel data, int _)
          yValueMapper,
      required List<ActiveAlarmAgingBarChartModel> chartData}) {
    return ColumnSeries<ActiveAlarmAgingBarChartModel, String>(
      name: name,
      color: color,
      dataSource: chartData,
      xValueMapper: (ActiveAlarmAgingBarChartModel data, _) => data.title,
      yValueMapper: yValueMapper,
      onPointDoubleTap: (point) {
        Map<String, dynamic>? entity;

        if (point.pointIndex != null) {
          entity = chartData[point.pointIndex!].entity;

          DateTime start = DateTime.fromMillisecondsSinceEpoch(startDate);

          DateTime end = DateTime.fromMillisecondsSinceEpoch(endDate);

          List<Map<String, dynamic>> filterValues = [
            getArguments(
              alarmKey: name,
            ),
            {
              "key": "dateRange",
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
            AlarmsListScreen.id,
            arguments: {
              "filterValues": filterValues,
            },
          );
        }
      },
      // (FirePanelBarchartModel data, _) =>
      //     data.fireAlarm,
    );
  }

  getTemplateKey(Level dropdownType) {
    switch (dropdownType) {
      case Level.community:
        return "community";
      case Level.subCommunity:
        return "siteGroup";
      case Level.site:
        return "site";
      case Level.space:
        return "spaces";

      default:
        return "community";
    }
  }

  Map<String, dynamic> getArguments({
    required String alarmKey,
  }) {
    switch (alarmKey) {
      case "Critical":
        return {
          "key": "criticality",
          "filterKey": "criticalities",
          "identifier": [
            "CRITICAL",
          ],
          "values": [
            {
              "name": "Critical",
              "data": "CRITICAL",
            }
          ]
        };

      case "Total":
        return {
          "key": "workOrders",
          "filterKey": "workOrderStatus",
          "identifier": "ALL",
          "values": [
            {
              "name": "All Alarms",
              "data": "ALL",
            }
          ],
        };

      case "Shutdown":
        return {
          "key": "category",
          "filterKey": "groups",
          "identifier": ["SHUTDOWN"],
          "values": [
            {
              "name": "Shutdown",
              "data": "SHUTDOWN",
            }
          ]
        };

      default:
        return {};
    }
  }
}
