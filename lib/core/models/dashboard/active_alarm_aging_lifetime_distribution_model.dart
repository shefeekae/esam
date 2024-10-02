// To parse this JSON data, do
//
//     final activeAlarmAgingDistributionData = activeAlarmAgingDistributionDataFromJson(jsonString);

import 'dart:convert';

ActiveAlarmAgingDistributionData activeAlarmAgingDistributionDataFromJson(
        String str) =>
    ActiveAlarmAgingDistributionData.fromJson(json.decode(str));

String activeAlarmAgingDistributionDataToJson(
        ActiveAlarmAgingDistributionData data) =>
    json.encode(data.toJson());

class ActiveAlarmAgingDistributionData {
  Map<String, GetAlarmAgeingDatum>? getAlarmAgeingData;

  ActiveAlarmAgingDistributionData({
    this.getAlarmAgeingData,
  });

  factory ActiveAlarmAgingDistributionData.fromJson(
          Map<String, dynamic> json) =>
      ActiveAlarmAgingDistributionData(
        getAlarmAgeingData: Map.from(json["getAlarmAgeingData"]!).map((k, v) =>
            MapEntry<String, GetAlarmAgeingDatum>(
                k, GetAlarmAgeingDatum.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "getAlarmAgeingData": Map.from(getAlarmAgeingData!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class GetAlarmAgeingDatum {
  int? shutdown;
  int? critical;
  int? total;

  GetAlarmAgeingDatum({
    this.shutdown,
    this.critical,
    this.total,
  });

  factory GetAlarmAgeingDatum.fromJson(Map<String, dynamic> json) =>
      GetAlarmAgeingDatum(
        shutdown: json["shutdown"],
        critical: json["critical"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "shutdown": shutdown,
        "critical": critical,
        "total": total,
      };
}
