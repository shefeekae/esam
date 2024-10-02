// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/services/charts/line_series_services.dart';
import 'package:nectar_assets/core/services/sub_community/sub_community_heirarchy_prediction_list_services.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import '../../../alarms/widgets/alarm_data_trend_chart.dart';

class ChwEnergyAnalysisLineChart extends StatelessWidget {
  final int startDate;
  final String? id;
  final Insights insights;

  ChwEnergyAnalysisLineChart({
    Key? key,
    required this.startDate,
    required this.id,
    required this.insights,
  }) : super(key: key);

  final LineSeriesServices lineSeriesServices = LineSeriesServices();

  @override
  Widget build(BuildContext context) {
    return QueryWidget(
        options: GraphqlServices().getQueryOptions(
          rereadPolicy: true,
          query: SubCommunityHeirarchyPerdictionListServices()
              .getQueryMethod(insights),
          variables: {
            "startDate": startDate,
            "endDate": 0,
            "id": id,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          String key = "";

          switch (insights) {
            case Insights.community:
              key = "getCommunityForecast";
              break;

            case Insights.subCommunity:
              key = "getSubCommunityForecast";
              break;
            case Insights.site:
              key = "getSiteForecast";
              break;
            case Insights.space:
              // TODO: Handle this case.
              break;
          }

          List predictions = result.data?[key]?['predictions'] ?? [];

          if (result.isNotLoading && predictions.isEmpty) {
            return const SizedBox();
          }

          List<ChartData> actualList = getChartData(predictions, "actual");
          List<ChartData> predictedList =
              getChartData(predictions, "predicted");

          return Skeletonizer(
            enabled: result.isLoading,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: BgContainer(
                title: "CHW Energy Analysis",
                child: SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    enableDoubleTapZooming: true,
                    enablePanning: true,
                  ),
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    shared: true,
                  ),
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                    tooltipSettings: InteractiveTooltip(
                      color: Colors.grey.shade500,
                      borderColor: Colors.grey.shade500,
                    ),
                  ),
                  primaryXAxis: DateTimeAxis(),
                  primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat
                        .compact(), // Using to show the values like 10k, 1M, 1.5M
                  ),
                  series: [
                    lineSeriesServices.getLineSeries(
                      list: predictedList,
                      name: "Predicted",
                      color: Colors.blue,
                    ),
                    lineSeriesServices.getLineSeries(
                      list: actualList,
                      name: "Actual",
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // ===========================================================================
  // Converting the response list to chart list

  List<ChartData> getChartData(List predictions, String key) {
    return predictions.where((element) => element['type'] == key).map((e) {
      DateTime? dateTime = DateTime.tryParse(e['date'] ?? "");

      num value = e['value'] ?? 0;

      return ChartData(
        dateTime,
        value.toDouble(),
      );
    }).toList();
  }
}
