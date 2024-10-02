// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProgressBarsModel {
  double progressValue;
  String value;
  Color color;
  String label;
  String sutitle;

  ProgressBarsModel({
    required this.progressValue,
    required this.value,
    required this.color,
    required this.label,
    this.sutitle = "",
  });
}

Map<int, List<ProgressBarsModel>> customCircularModelMap = {
  0: [
    ProgressBarsModel(
      progressValue: 10,
      value: "400",
      color: Colors.amber,
      label: "Connected",
    ),
    ProgressBarsModel(
      progressValue: 80,
      value: "10",
      color: Colors.purple,
      label: "Not Connected",
    ),
    ProgressBarsModel(
      progressValue: 10,
      value: "40",
      color: Colors.red,
      label: "Frequently communicating",
    ),
  ],
  1: [
    ProgressBarsModel(
      progressValue: 90,
      value: "40",
      color: Colors.black,
      label: "abce",
    ),
    ProgressBarsModel(
      progressValue: 8,
      value: "10",
      color: Colors.green,
      label: "Not Connected",
    ),
    ProgressBarsModel(
      progressValue: 8,
      value: "10",
      color: Colors.green,
      label: "Not Connected",
    ),
  ],
  2: [
    ProgressBarsModel(
      progressValue: 10,
      value: "400",
      color: Colors.amber,
      label: "Connected",
    ),
    ProgressBarsModel(
      progressValue: 80,
      value: "10",
      color: Colors.grey,
      label: "Not Connected",
    ),
    ProgressBarsModel(
      progressValue: 10,
      value: "40",
      color: Colors.lightBlue,
      label: "Frequently communicating",
    ),
  ],
};

Map<int, List<ProgressBarsModel>> customLinearProgressBarModelMap = {
  0: [
    ProgressBarsModel(
      progressValue: 50,
      value: "100",
      color: Colors.red.shade600,
      label: "Critical",
    ),
    ProgressBarsModel(
      progressValue: 40,
      value: "80",
      color: Colors.orange.shade700,
      label: "High",
    ),
  ],
  1: [
    ProgressBarsModel(
      progressValue: 10,
      value: "20",
      color: Colors.amber,
      label: "Medium",
    ),
    ProgressBarsModel(
      progressValue: 20,
      value: "50",
      color: Colors.purple,
      label: "Shutdown",
    ),
  ],
};
