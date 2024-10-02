import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../core/services/panels/panels_instights_charts_services.dart';

class FirePanelInsightsPieChart extends StatelessWidget {
  const FirePanelInsightsPieChart({
    required this.chartData,
    this.isLoading = false,
    super.key,
  });

  final List<ChartData> chartData;
  final bool isLoading;
  // final List<ChartData> chartData = [
  //   ChartData(
  //     label: "Fire Alarm",
  //     value: 100,
  //     color: Colors.red,
  //   ),
  //   ChartData(
  //     label: "Dirty",
  //     value: 100,
  //     color: Colors.amber,
  //   ),
  //   ChartData(
  //     label: "Disabled",
  //     value: 50,
  //     color: Colors.grey,
  //   ),
  //   ChartData(
  //     label: "Common Fault",
  //     value: 50,
  //     color: Colors.orange.shade700,
  //   ),
  //   ChartData(
  //     label: "Healthy",
  //     value: 38,
  //     color: Colors.green,
  //   ),
  //   ChartData(
  //     label: "Head Missing",
  //     value: 62,
  //     color: Colors.blue,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    double totalData = 0;
    try {
      totalData = chartData
          .map((e) => e.value)
          .reduce((value, element) => value + element);
    } catch (e) {
      print(e);
      // TODO
    }

    return SizedBox(
      height: 40.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Skeletonizer(
          enabled: isLoading,
          child: SfCircularChart(
              backgroundColor: ThemeServices().getBgColor(context),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                tooltipPosition: TooltipPosition.pointer,
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              series: <CircularSeries>[
                // Render pie chart
                DoughnutSeries<ChartData, String>(
                  enableTooltip: true,
                  onPointDoubleTap: (pointInteractionDetails) {
                    dynamic label = pointInteractionDetails
                        .dataPoints?[pointInteractionDetails.viewportPointIndex
                                ?.toInt() ??
                            0]
                        .x;

                    if (label != null && label.runtimeType == String) {
                      PanelsInsightsServices().goToAlarmPage(
                        context,
                        title: label,
                      );
                    }
                  },
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: ThemeServices().getLabelColor(context),
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    labelPosition: ChartDataLabelPosition.inside,
                    // Format the label text to show percentage values
                    // format: 'point.y%',
                  ),
                  dataSource: chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  dataLabelMapper: (ChartData sales, _) {
                    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

                    return '${((sales.value / totalData) * 100).toStringAsFixed(1)}%'
                        .replaceAll(regex, '');
                  },
                  xValueMapper: (ChartData data, _) => data.label,
                  yValueMapper: (ChartData data, _) => data.value,
                )
              ]),
        ),
      ),
    );
  }
}
