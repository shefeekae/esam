import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/alarms/alarm_%20asset_history_model.dart';
import 'package:nectar_assets/core/models/charts/plot_band_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/model/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartHelper {
  // ============================================================================
  // This method is used to gettiing the plot bands and annotations
  // Plot Bands are used to show the string values in chart
  // Annotations are used to show the labels of plotbands.

  Map<String, dynamic> generatePlotbandsAndAnnotations({
    required List<PointData> list,
    required List<PointData> lineSeriesList,
  }) {
    List<PlotBandModel> plotBands = [];
    List<AnnotationModel> annotations = [];
    // final int length = _chartData.length;
    DateTime? start;
    DateTime? end;
    String? previousStatus;

    List<Values> lineSeriesAllValuesList = lineSeriesList
        .expand<Values>((element) => element.values ?? [])
        .toList();

    int maxValue;
    num minValue;
    double axisStart;
    double axisEnd;
    int percentageValue;

    try {
      maxValue = lineSeriesAllValuesList
          .map((value) => value.data)
          .reduce((max, current) => max > current ? max : current);
    } catch (e) {
      maxValue = 20;
    }

    try {
      minValue = lineSeriesAllValuesList
          .map((value) => value.data)
          .reduce((min, current) => min > current ? current : min);
    } catch (e) {
      minValue = 0;
    }

    percentageValue = (maxValue * 0.1).toInt();

    if (lineSeriesList.isNotEmpty) {
      axisStart = minValue.toDouble() - (minValue * 0.2);

      axisEnd = axisStart - percentageValue;
    } else {
      axisStart = 10;
      axisEnd = 30;
    }

    for (var i = 0; i < list.length; i++) {
      List<Values> values = list[i].values ?? [];

      String name = list[i].displayName ?? "";

      for (int i = 0; i < values.length; i++) {
        final ChartSampleData data = ChartSampleData(
          DateTime.fromMillisecondsSinceEpoch(values[i].dataTime ?? 0),
          0,
          values[i].data,
        );
        if (data.status != null) {
          start ??= data.x;
        }

        if (data.status != null && previousStatus != null) {
          end = data.x;
        }

        if (start != null && end != null) {
          plotBands.add(
            PlotBandModel(
              start: start,
              end: end,
              associatedAxisStart: axisStart,
              associatedAxisEnd: axisEnd,
              color: getPlotBandColor(previousStatus),
              text: previousStatus ?? "",
              textStyle: const TextStyle(color: Colors.transparent),
              pointName: name,
            ),
          );

          start = data.status != null ? data.x : null;
          end = null;
          previousStatus = null;
        }

        previousStatus = data.status;
      }

      if (lineSeriesList.isNotEmpty) {
        annotations.add(
          AnnotationModel(
            name: name,
            point: axisStart,
          ),
        );
      } else {
        annotations.add(
          AnnotationModel(
            name: name,
            point: axisEnd,
          ),
        );
      }

      if (lineSeriesList.isNotEmpty) {
        axisStart = axisStart - percentageValue - (percentageValue * 0.5);

        axisEnd = axisEnd - percentageValue - (percentageValue * 0.5);
      } else {
        axisStart = axisStart + 50;
        axisEnd = axisEnd + 50;
      }
    }

    return {
      "plotBands": plotBands,
      "annotations": annotations,
    };
  }

  // =============================================================================
  // Getting the plot bands color

  Color getPlotBandColor(String? status) {
    switch (status?.toUpperCase()) {
      case "ON":
      case "APPLIED":
      case "ACTIVE":
      case "TRUE":
      case "FORWARD":
      case "READY":
      case "PRESENT":
      case "MOVING":
      case "AUTO":
      case "RUNNING":
      case "NORMAL":
      case "ENABLE":
      case "HEALTHY":
      case "CLOSE":
      case "DISENGAGED":
      case "CLOSED":
      case "MAINTAINED":
        return Colors.green;

      case "OFF":
      case "NOT APPLIED":
      case "INACTIVE":
      case "FALSE":
      case "REVERSE":
      case "NOT READY":
      case "ABSENT":
      case "NOT MOVING":
      case "HAND":
      case "STOPPED":
      case "TRIPPED":
      case "DOWN":
      case "DISABLE":
      case "FAULTY":
      case "OPEN":
      case "ENGAGED":
      case "UNDER COOLING":
        return Colors.red;

      case "IDLE":
        return Colors.orange;

      case "OVER COOLING":
        return Colors.blue;

      case "WARM":
        return Colors.yellow;

      default:
        return Colors.amber;
    }
  }

  // ============================================================================
  // Trackbacll builder is used to show the selcted datetime data

  Widget trackballBuilder({
    required TrackballDetails trackballDetails,
    required List<PlotBandModel> plotBandsModel,
    required List<PointData> stringPointsList,
    required bool lineSeriesIsEmpty,
  }) {
    Widget? current;

    DateTime selectedDateTime =
        trackballDetails.groupingModeInfo!.points.first.x;

    String formatedDate =
        DateFormat("MMM dd yyyy").add_jms().format(selectedDateTime);

    List<Map> plotBandsDataList = [];

    for (final PlotBandModel plotBand in plotBandsModel) {
      final DateTime plotBandStart = plotBand.start!;
      final DateTime plotBandEnd = plotBand.end!;

      DateTime selectedDateTime =
          trackballDetails.groupingModeInfo!.points.first.x;

      if (selectedDateTime.isAtSameMomentAs(plotBandStart) ||
          selectedDateTime.isAfter(plotBandStart) &&
              selectedDateTime.isBefore(plotBandEnd)) {
        plotBandsDataList.add({
          "name": plotBand.pointName,
          "value": plotBand.text,
        });
      }
    }

    plotBandsDataList = plotBandsDataList.reversed.toList();

    String text = "";

    if (lineSeriesIsEmpty) {
      text = 'Date  : $formatedDate \n'
          "${plotBandsDataList.map((e) => "${e['name']} : ${e['value']}").join("\n")}";
    } else {
      List list = [];

      List<CartesianSeries<dynamic, dynamic>> visibleSeriesList =
          trackballDetails.groupingModeInfo?.visibleSeriesList ?? [];
      List<CartesianChartPoint<dynamic>> points =
          trackballDetails.groupingModeInfo?.points ?? [];

      try {
        for (var i = 0; i < visibleSeriesList.length; i++) {
          list.add("${visibleSeriesList[i].name} : ${points[i].y}");
        }
      } catch (e) {
        list = [];
      }

      text = 'Date  : $formatedDate \n'
          '${list.map((e) => e).join("\n")}\n'
          "${plotBandsDataList.map((e) => "${e['name']} : ${e['value']}").join("\n")}";
    }

    current ??= Text(
      text,
      style: const TextStyle(color: Colors.white),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: current,
    );
  }
}
