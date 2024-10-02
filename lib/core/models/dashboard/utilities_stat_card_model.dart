import 'package:flutter/material.dart';

class UtilitiesStatusCardModel {
  final String name;
  final String currentYear;
  final String previousYear;
  final String currentValue;
  final String previousValue;
  final bool? increased;
  final String percentage;
  final Color? color;
  final String compareValue;
  final String unit;

  UtilitiesStatusCardModel({
    required this.unit,
    required this.compareValue,
    required this.currentValue,
    required this.previousValue,
    required this.name,
    required this.currentYear,
    required this.previousYear,
    required this.increased,
    required this.percentage,
    this.color,
  });
}
