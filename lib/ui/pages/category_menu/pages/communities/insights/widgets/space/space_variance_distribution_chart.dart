import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/space/get_space_insight_visulaization.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../../core/services/charts/line_series_services.dart';
import '../../../../../../../shared/widgets/container/background_container.dart';
import '../../../../alarms/widgets/alarm_data_trend_chart.dart';

class SpaceVarianceSpaceDistributionChart extends StatelessWidget {
  SpaceVarianceSpaceDistributionChart(
      {required this.varianceDistributionList,
      required this.formatedStartDate,
      required this.formatedEndDate,
      super.key});

  final String formatedStartDate;
  final String formatedEndDate;

  final List<VarianceDistribution> varianceDistributionList;

  final LineSeriesServices lineSeriesServices = LineSeriesServices();

  @override
  Widget build(BuildContext context) {
    List<VarianceDistribution> avgVariance = varianceDistributionList
        .where((element) => element.key == VarianceDistributionKey.AVG_VARIANCE)
        .toList();

    List<VarianceDistribution> avgTemperature = varianceDistributionList
        .where(
            (element) => element.key == VarianceDistributionKey.AVG_TEMPERATURE)
        .toList();

    List<VarianceDistribution> avgSetpoint = varianceDistributionList
        .where((element) => element.key == VarianceDistributionKey.AVG_SETPOINT)
        .toList();

    return BgContainer(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      title:
          "Variance Distribution from $formatedStartDate to $formatedEndDate",
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
            list: listConvertToChartData(avgTemperature),
            name: "Avg Temperature",
            color: Colors.orange,
          ),
          lineSeriesServices.getLineSeries(
            list: listConvertToChartData(avgSetpoint),
            name: "Avg Setpoint",
            color: Colors.lime.shade600,
          ),
          lineSeriesServices.getLineSeries(
            list: listConvertToChartData(avgVariance),
            name: "Avg Variance",
            color: Colors.blue.shade600,
          ),
        ],
      ),
    );
  }

  List<ChartData> listConvertToChartData(List<VarianceDistribution> list) {
    return list.map((e) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(e.date ?? 0);

      num value = e.value ?? 0;

      return ChartData(
        dateTime,
        value.toDouble(),
      );
    }).toList();
  }

}
