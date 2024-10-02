import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/schemas/alarms_chart_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/alarms_list.dart';
import 'package:nectar_assets/ui/shared/functions/reorder_map.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../core/models/charts/multi_bar_chart_model.dart';
import '../../../../../../../core/services/communities/community_insights_services.dart';
import '../../../../../../../core/services/panels/panels_instights_charts_services.dart';
import '../../../../../../../core/services/theme/theme_services.dart';

class ActiveAndShutdownCriticalAlarmsBarChart extends StatelessWidget {
  ActiveAndShutdownCriticalAlarmsBarChart(
      {required this.identifier,
      super.key,
  
      required this.entity,
      required this.insights});

  final UserDataSingleton userData = UserDataSingleton();

  final String? identifier;
  final Map<String, dynamic> entity;
 
  final Insights insights;
  final List<MultiBarChartData> chartData = [];

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        rereadPolicy: true,
        query: AlarmChartSchemas.getAlarmAgeingData,
        variables: {
          "data": {
            "ages": PanelsInsightsServices().getFirePanelAgeData(),
            "filter": {
              "domain": userData.domain,
              "status": ["active"],
              "searchTagIds": [
                identifier,
              ]
            }
          }
        },
      ),
      builder: (resul, {fetchMore, refetch}) {
        Map<String, dynamic> data = resul.data?['getAlarmAgeingData'] ?? {};
        // resul.data?['getAlarmAgeingData'] ?? {};

        Map<String, dynamic> reorderData = reorderMap(
          keyOrder: [
            'Today',
            'Yesterday',
            '2-5 Days',
            '6-10 Days',
            '11-30 Days',
            '31+ Days'
          ],
          myMap: data,
        );

        reorderData.forEach((key, value) {
          String title = key;

          int total = value?['total'] ?? 0;
          int critical = value?['critical'] ?? 0;
          int shutdown = value?['shutdown'] ?? 0;

          // if (total != 0 && critical != 0 && shutdown != 0) {
          chartData.add(
            MultiBarChartData(
              name: title,
              y: total.toDouble(),
              y1: critical.toDouble(),
              y2: shutdown.toDouble(),
            ),
          );
          // }
        });

        bool allDataisEmpty = chartData.every(
            (element) => element.y == 0 && element.y1 == 0 && element.y2 == 0);

        if (resul.isNotLoading && chartData.isEmpty) {
          return const SizedBox();
        }

        if (allDataisEmpty) {
          return const SizedBox();
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: BgContainer(
            title: "Active - Shutdown and Critical Alarms",
            child: Skeletonizer(
              enabled: resul.isLoading,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                    fontSize: 8.sp,
                  ),
                ),
                backgroundColor: ThemeServices().getBgColor(context),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  // shared: true,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                ),
                legend: Legend(
                  isVisible: true,
                  // overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom,
                ),

                series: <CartesianSeries>[
                  buildColumnSeries(
                    context,
                    name: "Total",
                    color: Colors.blue,
                    yValueMapper: (data, p1) => data.y,
                  ),
                  buildColumnSeries(
                    context,
                    name: "Critical",
                    color: Colors.red,
                    yValueMapper: (data, p1) => data.y1,
                  ),
                  buildColumnSeries(
                    context,
                    name: "Shutdown",
                    color: Colors.grey,
                    yValueMapper: (data, p1) => data.y2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// =========================================================================

  ColumnSeries<MultiBarChartData, String> buildColumnSeries(
    BuildContext context, {
    required String name,
    required Color color,
    required num? Function(MultiBarChartData data, int _) yValueMapper,
  }) {
    return ColumnSeries<MultiBarChartData, String>(
      onPointDoubleTap: (point) {
        if (point.pointIndex == null) {
          return;
        }

        Map<String, dynamic> dateMap =
            PanelsInsightsServices().getFirePanelAgeData();

        int? startDate =
            dateMap[chartData[point.pointIndex!].name]?['startDate'];
        int? endDate = dateMap[chartData[point.pointIndex!].name]?['endDate'];

        if (startDate == null || endDate == null) {
          return;
        }

        DateFormat dateFormat = DateFormat("MMM, d - yyyy");

        String formatedStart =
            dateFormat.format(DateTime.fromMillisecondsSinceEpoch(startDate));

        String formatedEnd =
            dateFormat.format(DateTime.fromMillisecondsSinceEpoch(endDate));

        Map<String, dynamic> dateRangeMap = {
          "key": "dateRange",
          "filterKey": "date",
          "identifier": {
            "startDate": startDate,
            "endDate": endDate,
          },
          "values": [
            {
              "name": "$formatedStart - $formatedEnd",
            }
          ]
        };

        Map<String, dynamic> map = {
          "key": CommunityInsightsServices().getDrillDownFilterKey(insights),
          "filterKey": "searchTagIds",
          "identifier": [identifier],
          "values": [
            {
              "name": entity['data']?['name'],
              "data": entity,
            }
          ]
        };

        if (name == "Total") {
          Navigator.of(context).pushNamed(AlarmsListScreen.id, arguments: {
            "filterValues": [
              map,
              dateRangeMap,
            ]
          });
        } else if (name == "Critical") {
          Navigator.of(context).pushNamed(AlarmsListScreen.id, arguments: {
            "filterValues": [
              {
                "key": "criticality",
                "filterKey": "criticalities",
                "identifier": ["CRITICAL"],
                "values": [
                  {
                    "name": "Critical",
                    "data": "CRITICAL",
                  }
                ]
              },
              map,
              dateRangeMap,
            ]
          });
        } else if (name == "Shutdown") {
          Navigator.of(context).pushNamed(AlarmsListScreen.id, arguments: {
            "filterValues": [
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
              },
              map,
              dateRangeMap,
            ]
          });
        }
      },
      name: name,
      color: color,
      dataSource: chartData,
      xValueMapper: (MultiBarChartData data, _) => data.name,
      yValueMapper: yValueMapper,
      // (FirePanelBarchartModel data, _) =>
      //     data.fireAlarm,
    );
  }
}
