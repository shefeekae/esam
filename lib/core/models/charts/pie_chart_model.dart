// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/dashboard/all_alarm_space_distribution_data_model.dart';

class ChartData {
  final String label;
  final double value;
  final Color? color;
  final Map<String, dynamic>? identifier;
  final Entity? entity;
  final Map<String, dynamic>? utilityEntity;
  final Map<String, dynamic>? data;

  ChartData({
    required this.label,
    required this.value,
    this.color,
    this.identifier,
    this.entity,
    this.utilityEntity,
    this.data,
  });
}
