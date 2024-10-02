import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/alarms/alarm_%20asset_history_model.dart';
import 'package:nectar_assets/core/models/charts/plot_band_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/functions/chart_functions.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/model/chart_data_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/alarm_data_trend_chart.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataTrendsChart extends StatelessWidget {
  DataTrendsChart({
    super.key,
    required this.list,
    required this.endDate,
    required this.startDate,
  });

  final int startDate;
  final int endDate;
  final List<PointData> list;
  final ChartHelper chartHelper = ChartHelper();

  @override
  Widget build(BuildContext context) {
    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startDate);

    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endDate);

    List<PointData> stringPointsList =
        list.where((element) => element.dataType == "String").toList();

    List<PointData> lineSeriesPointList = list
        .where((element) =>
            element.dataType == "Integer" ||
            element.dataType == "Double" ||
            element.dataType == "Float")
        .toList();

    Map<String, dynamic> map = chartHelper.generatePlotbandsAndAnnotations(
      list: stringPointsList,
      lineSeriesList: lineSeriesPointList,
    );

    final List<PlotBandModel> plotBandsModel = map['plotBands'] ?? [];

    final List<AnnotationModel> annotations = map['annotations'] ?? [];

    if (lineSeriesPointList.isEmpty && plotBandsModel.isEmpty) {
      return SizedBox(
        height: 10.sp,
      );
    }

    List<DateTime?> allDateValues = [
      ...stringPointsList,
      ...lineSeriesPointList
    ].expand<Values>((element) => element.values ?? []).map((e) {
      if (e.dataTime == null) {
        return null;
      }
      return DateTime.fromMillisecondsSinceEpoch(e.dataTime!);
    }).toList();

    allDateValues = allDateValues.where((element) => element != null).toList();

    DateTime? lowestDate = allDateValues
        .reduce((current, next) => current!.isBefore(next!) ? current : next);

    // Finding the highest date
    DateTime? highest = allDateValues
        .reduce((current, next) => current!.isAfter(next!) ? current : next);

    int diffrenceHours = 0;

    if (lowestDate != null && highest != null) {
      diffrenceHours = highest.difference(lowestDate).inHours;
    } else {
      diffrenceHours = endDateTime.difference(startDateTime).inHours;
    }

    final List<PlotBand> plotBands = plotBandsModel.map((e) {
      return PlotBand(
        start: e.start,
        end: e.end,
        associatedAxisStart: e.associatedAxisStart,
        associatedAxisEnd: e.associatedAxisEnd,
        color: e.color,
        text: e.text,
        textStyle: const TextStyle(color: Colors.transparent),
      );
    }).toList();

    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: false,
        enableDoubleTapZooming: false,
        enablePanning: false,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      trackballBehavior: TrackballBehavior(
        enable: true,
        shouldAlwaysShow: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: InteractiveTooltip(
          color: Colors.grey.shade500,
          borderColor: Colors.grey.shade500,
        ),
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        builder: (BuildContext context, TrackballDetails trackballDetails) {
          return chartHelper.trackballBuilder(
            trackballDetails: trackballDetails,
            plotBandsModel: plotBandsModel,
            stringPointsList: stringPointsList,
            lineSeriesIsEmpty: lineSeriesPointList.isEmpty,
          );
        },
      ),
      primaryXAxis: DateTimeAxis(
        minimum: lowestDate ?? startDateTime,
        maximum: highest ?? endDateTime,
        plotBands: stringPointsList.isNotEmpty ? plotBands : null,
      ),
      primaryYAxis: NumericAxis(
        minimum: plotBands.isNotEmpty && lineSeriesPointList.isNotEmpty
            ? plotBands.last.associatedAxisEnd
            : null,
      ),
      annotations: List.generate(annotations.length, (index) {
        AnnotationModel model = annotations[index];

        return CartesianChartAnnotation(
          widget: Padding(
            padding: EdgeInsets.only(bottom: 11.sp),
            child: Text(
              model.name,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          coordinateUnit: CoordinateUnit.point,
          x: lowestDate?.add(
                Duration(
                  hours: (diffrenceHours * 0.2).round(),
                ),
              ) ??
              startDateTime.add(
                Duration(
                  hours: (diffrenceHours * 0.2).round(),
                ),
              ),
          y: model.point,
        );
      }),
      series: lineSeriesPointList.isNotEmpty
          ? List.generate(lineSeriesPointList.length, (index) {
              PointData pointData = lineSeriesPointList[index];
              List<Values> values = pointData.values ?? [];
              return LineSeries<ChartData, DateTime>(
                name: pointData.displayName,
                dataSource: List.generate(values.length, (index) {
                  Values value = values[index];

                  DateTime? dateTime = value.dataTime == null
                      ? null
                      : DateTime.fromMillisecondsSinceEpoch(value.dataTime!);

                  double yValue = value.data.toDouble();

                  return ChartData(dateTime, yValue);
                }),
                xValueMapper: (ChartData data, _) => data.x ?? DateTime.now(),
                yValueMapper: (ChartData data, _) => data.y,
              );
            })
          : List.generate(
              stringPointsList.length,
              (index) {
                PointData pointData = stringPointsList[index];
                List<Values> values = pointData.values ?? [];

                return LineSeries<ChartData, DateTime>(
                    color: Colors.transparent,
                    // isVisible: false,
                    enableTooltip: false,
                    dataSource: List.generate(values.length, (index) {
                      Values value = values[index];

                      DateTime? dateTime = value.dataTime == null
                          ? null
                          : DateTime.fromMillisecondsSinceEpoch(
                              value.dataTime!);

                      return ChartData(dateTime, 200);
                    }),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y);
              },
            ),
    );
  }
}
