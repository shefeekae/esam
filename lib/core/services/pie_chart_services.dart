import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/pie_chart_model.dart';

class PieChartServices {
  List<PieChartModel> getChartData() {
    final List<PieChartModel> chartData = [
      PieChartModel(
        dataHours: '10h 2m',
        value: 1500,
        color: Colors.green,
        label: "ON"
      ),
      PieChartModel(
        dataHours: '2h 2m',
        value: 2000,
        color: Colors.red.shade800,
        label: "OFF",
      ),
      PieChartModel(
        dataHours: '1h 2m',
        value: 1000,
        color: Colors.amber.shade600,
        label: "IDLE"
      ),
      PieChartModel(
        dataHours: '1h 2m',
        value: 1000,
        color: Colors.blue.shade600,
        label: "STALE"
      ),
    ];
    return chartData;
  }
}
