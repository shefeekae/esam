import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/services/charts/bar_chart_data.dart';

class CategoryAxisBarChart extends StatelessWidget {
  const CategoryAxisBarChart({
    required this.dataSource,
    required this.title,
    this.onDoubleTap,
    this.sortingOrder,
    super.key,
  });

  final List<BarChartData> dataSource;
  final String title;
  final void Function(BarChartData barChartData)? onDoubleTap;
  final SortingOrder? sortingOrder;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        maximumLabelWidth: 100.sp,
      ),
      primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
      tooltipBehavior: TooltipBehavior(enable: true),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
      ),
      series: <ChartSeries<BarChartData, String>>[
        BarSeries<BarChartData, String>(
          name: title,
          sortingOrder: sortingOrder,
          color: Theme.of(context).primaryColor,
          dataSource: dataSource,
          xValueMapper: (BarChartData data, _) => data.x,
          yValueMapper: (BarChartData data, _) => data.y,
          onPointDoubleTap: (details) {
            int? index = details.pointIndex;

            if (index != null) {
              onDoubleTap?.call(dataSource[index]);
            }
          },
          // pointColorMapper: (datum, index) {
          //   return ColorHelpers().getRandomLightColor();
          // },
        )
      ],
    );
  }
}
