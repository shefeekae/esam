


import 'dart:ui';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../ui/pages/category_menu/pages/alarms/widgets/alarm_data_trend_chart.dart';

class LineSeriesServices {



  // ===========================================================================
  // Returning the Line Serires

  LineSeries<ChartData, DateTime> getLineSeries({
    required List<ChartData> list,
    required String name,
    Color? color,
  }) {
    return LineSeries<ChartData, DateTime>(
        color: color,
        name: name,
        dataSource: List.generate(list.length, (index) {
          ChartData value = list[index];

          DateTime? dateTime = value.x;

          double yValue = value.y.toDouble();

          return ChartData(dateTime, yValue);
        }),
        xValueMapper: (ChartData data, _) => data.x ?? DateTime.now(),
        yValueMapper: (ChartData data, _) => data.y,
        markerSettings: const MarkerSettings(
          isVisible: true,
        ));
  }
  
}