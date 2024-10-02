import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../../../core/services/graphql_services.dart';

class HighConsumptionBarChart extends StatelessWidget {
  const HighConsumptionBarChart({
    required this.equipmentEntity,
    required this.startDate,
    required this.endDate,
    required this.utilityType,
    required this.comparePeriod,
    super.key,
  });

  final Map<String, dynamic> equipmentEntity;
  final int startDate;
  final int endDate;
  final String utilityType;
  final int comparePeriod;

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
        query: AlarmsSchema.getConsumptionComparison,
        variables: {
          "data": {
            "equipment": equipmentEntity,
            "startDate": startDate,
            "endDate": endDate,
            "resultSplit": "DAILY",
            "utilityType": utilityType,
            "comparePeriod": comparePeriod,
            "stats": false,
            "benchMark": false
          }
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        Map<String, dynamic>? map = result.data?['getConsumptionComparison'];

        List period = map?["period"] ?? [];
        List comparePeriod = map?['comparePeriod'] ?? [];

        return Skeletonizer(
          enabled: result.isLoading,
          child: BgContainer(
           
            child: SfCartesianChart(
              title: ChartTitle(text: "Consumption Comparison"),
              primaryXAxis: CategoryAxis(),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: List.generate(period.length, (index) {
                    Map<String, dynamic> map = period[index];

                    int dateTimeEpoch = map['dateTime'] ?? 0;

                    DateTime dateTime =
                        DateTime.fromMillisecondsSinceEpoch(dateTimeEpoch);

                    String formated = DateFormat.MMMd().format(dateTime);

                    num consumption = map['consumption'];

                    return _ChartData(formated, consumption.toDouble());
                  }),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name:
                      'Consumption ${period.isNotEmpty ? period.first['year'] : ""}',
                  color: const Color.fromRGBO(8, 142, 255, 1),
                ),
                ColumnSeries<_ChartData, String>(
                  dataSource: List.generate(comparePeriod.length, (index) {
                    Map<String, dynamic> map = comparePeriod[index];

                    int dateTimeEpoch = map['dateTime'] ?? 0;

                    DateTime dateTime =
                        DateTime.fromMillisecondsSinceEpoch(dateTimeEpoch);

                    String formated = DateFormat.MMMd().format(dateTime);

                    num consumption = map['consumption'];

                    return _ChartData(formated, consumption.toDouble());
                  }),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name:
                      'Consumption ${comparePeriod.isNotEmpty ? comparePeriod.first['year'] : ""}',
                  color: Colors.green,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
