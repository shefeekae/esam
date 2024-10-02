// To parse this JSON data, do
//
//     final getUtilizationModel = getUtilizationModelFromJson(jsonString);

import 'dart:convert';

GetUtilizationModel getUtilizationModelFromJson(Map<String, dynamic> map) =>
    GetUtilizationModel.fromJson(map);

String getUtilizationModelToJson(GetUtilizationModel data) =>
    json.encode(data.toJson());

class GetUtilizationModel {
  GetUtilizationModel({
    this.getUtilizationData,
  });

  GetUtilizationData? getUtilizationData;

  factory GetUtilizationModel.fromJson(Map<String, dynamic> json) =>
      GetUtilizationModel(
        getUtilizationData: json["getUtilizationData"] == null
            ? null
            : GetUtilizationData.fromJson(json["getUtilizationData"]),
      );

  Map<String, dynamic> toJson() => {
        "getUtilizationData": getUtilizationData?.toJson(),
      };
}

class GetUtilizationData {
  GetUtilizationData({
    this.totalOperationalDuration,
    this.totalIdleDuration,
    this.utilizationRate,
    this.dailyAverage,
  });

  num? totalOperationalDuration;
  num? totalIdleDuration;
  double? utilizationRate;
  num? dailyAverage;

  factory GetUtilizationData.fromJson(Map<String, dynamic> json) =>
      GetUtilizationData(
        totalOperationalDuration: json["totalOperationalDuration"],
        totalIdleDuration: json["totalIdleDuration"],
        utilizationRate: json["utilizationRate"]?.toDouble(),
        dailyAverage: json["dailyAverage"],
      );

  Map<String, dynamic> toJson() => {
        "totalOperationalDuration": totalOperationalDuration,
        "totalIdleDuration": totalIdleDuration,
        "utilizationRate": utilizationRate,
        "dailyAverage": dailyAverage,
      };
}
