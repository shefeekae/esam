import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/utilities/model/bar_chart_model.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ConsumptionBarChartWidget extends StatelessWidget {
  const ConsumptionBarChartWidget({
    super.key,
    required this.yearValue,
    required this.chartList,
    required this.compareYearValue,
    required this.title,
  });

  final int yearValue;
  final List<UtilitiesBarChartData> chartList;
  final int compareYearValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return buildLayout(context);
  }

  Widget buildLayout(BuildContext context) {
    bool yearValueIsEmpty = chartList.every((element) {
      bool show = element.yearValue == null;

      return show;
    });

    bool compareYearValueIsEmpty = chartList.every((element) {
      bool show = element.compareYearValue == null;

      return show;
    });

    if (compareYearValueIsEmpty && yearValueIsEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: BgContainer(
        title: title,
        child: SfCartesianChart(
          backgroundColor: ThemeServices().getBgColor(context),
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
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
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 1),
            majorTickLines: const MajorTickLines(size: 0),
            labelAlignment: LabelAlignment.center,
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
          ),
          series: [
            ColumnSeries<UtilitiesBarChartData, String>(
              dataSource: chartList,
              xValueMapper: (data, index) => data.label,
              yValueMapper: (data, index) => data.compareYearValue,
              name: "Consumption $compareYearValue",
              color: Theme.of(context).colorScheme.secondary,
            ),
            ColumnSeries<UtilitiesBarChartData, String>(
                dataSource: chartList,
                xValueMapper: (data, index) => data.label,
                yValueMapper: (data, index) => data.yearValue,
                name: "Consumption $yearValue",
                color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}
