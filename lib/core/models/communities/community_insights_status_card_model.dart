import 'package:flutter/material.dart';

class CommunityInsightsStatusCardModel {
  final String name;
  final String value;
  final String compareYear;
  final String compareYearValue;
  final bool? increased;
  final String percentage;
  final Color? color;

  CommunityInsightsStatusCardModel({
    required this.name,
    required this.value,
    required this.compareYear,
    required this.compareYearValue,
    required this.increased,
    required this.percentage,
    this.color,
  });
}
