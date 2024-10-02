// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class PlotBandModel {
  final dynamic start;
  final dynamic end;
  final double associatedAxisStart;
  final double associatedAxisEnd;
  final Color color;
  final String text;
  final TextStyle? textStyle;
  final String pointName;

  PlotBandModel({
    required this.start,
    required this.end,
    required this.associatedAxisStart,
    required this.associatedAxisEnd,
    required this.color,
    required this.text,
    required this.pointName,
    this.textStyle,
  });
}
