import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/charts/pie_chart_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../functions/converters.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    required this.chartData,
    required this.onDoubleTap,
    this.isLoading = false,
    super.key,
    this.symbol = '',
  });

  final List<ChartData> chartData;
  final bool isLoading;
  final void Function(ChartData chartData) onDoubleTap;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    double totalData = 0;
    try {
      totalData = chartData
          .map((e) => e.value)
          .reduce((value, element) => value + element);
    } catch (e) {
      totalData = 0;
    }

    return Skeletonizer(
      enabled: isLoading,
      child: SfCircularChart(
          backgroundColor: ThemeServices().getBgColor(context),
          onTooltipRender: (TooltipArgs args) {
            int? index = args.pointIndex?.toInt();

            if (index == null) {
              return;
            }

            double value = args.dataPoints?[index].y.toDouble();

            args.text =
                '${args.dataPoints?[index].x}: ${Converter().formatNumber(value)} $symbol';
          },
          tooltipBehavior: TooltipBehavior(
            enable: true,
            tooltipPosition: TooltipPosition.pointer,
            // format: "point.x: $symbol",

            // builder: (data, point, series, pointIndex, seriesIndex) {
            //   return Text("${point.x} ");
            // },
          ),

          // legend: Legend(
          //   isVisible: true,
          //   position: LegendPosition.bottom,
          //   overflowMode: LegendItemOverflowMode.wrap,
          // ),
          series: <CircularSeries>[
            // Render pie chart
            DoughnutSeries<ChartData, String>(
              
              
              enableTooltip: true,
              // explode: true,
              radius: '90',
              onPointDoubleTap: (point) {
                // dynamic label = pointInteractionDetails
                //     .dataPoints?[
                //         pointInteractionDetails.viewportPointIndex?.toInt() ??
                //             0]
                //     .x;

                // dynamic value = pointInteractionDetails
                //     .dataPoints?[
                //         pointInteractionDetails.viewportPointIndex?.toInt() ??
                //             0]
                //     .y;

                // if (label != null && label.runtimeType == String) {
                //   onDoubleTap(label, value);
                // }
                if (point.pointIndex != null) {
                  // type = chartData[point.pointIndex!];

                  // title = chartData[point.pointIndex!].title;
                  onDoubleTap(chartData[point.pointIndex!]);
                }
              },
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                  color: ThemeServices().getLabelColor(context),
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                ),
                labelPosition: ChartDataLabelPosition.outside,
                overflowMode: OverflowMode.shift,

                // Format the label text to show percentage values
              ),
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              dataLabelMapper: (ChartData data, a) {
                RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

                return '${data.label}: ${((data.value / totalData) * 100).toStringAsFixed(2)}%'
                    .replaceAll(regex, '');
              },
              xValueMapper: (ChartData data, _) => data.label,
              yValueMapper: (ChartData data, _) =>
                  data.value == 0 ? null : data.value,
            )
          ]),
    );
  }

}
