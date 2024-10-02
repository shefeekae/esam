// To parse this JSON data, do
//
//     final equipmentTypeChartData = equipmentTypeChartDataFromJson(jsonString);

import 'dart:convert';

EquipmentTypeChartData equipmentTypeChartDataFromJson(String str) =>
    EquipmentTypeChartData.fromJson(json.decode(str));

String equipmentTypeChartDataToJson(EquipmentTypeChartData data) =>
    json.encode(data.toJson());

class EquipmentTypeChartData {
  List<GetTypeEventConsolidation>? getTypeEventConsolidation;

  EquipmentTypeChartData({
    this.getTypeEventConsolidation,
  });

  factory EquipmentTypeChartData.fromJson(Map<String, dynamic> json) =>
      EquipmentTypeChartData(
        getTypeEventConsolidation: json["getTypeEventConsolidation"] == null
            ? []
            : List<GetTypeEventConsolidation>.from(
                json["getTypeEventConsolidation"]!
                    .map((x) => GetTypeEventConsolidation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getTypeEventConsolidation": getTypeEventConsolidation == null
            ? []
            : List<dynamic>.from(
                getTypeEventConsolidation!.map((x) => x.toJson())),
      };
}

class GetTypeEventConsolidation {
  String? type;
  String? typeName;
  int? count;

  GetTypeEventConsolidation({
    this.type,
    this.typeName,
    this.count,
  });

  factory GetTypeEventConsolidation.fromJson(Map<String, dynamic> json) =>
      GetTypeEventConsolidation(
        type: json["type"],
        typeName: json["typeName"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "typeName": typeName,
        "count": count,
      };
}
