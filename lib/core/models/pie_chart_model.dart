// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class PieChartModel {
  final String dataHours;
  final Color color;
  final int value;
  final String label;

  PieChartModel({
    required this.value,
    required this.color,
    required this.dataHours,
    required this.label,
  });
}
