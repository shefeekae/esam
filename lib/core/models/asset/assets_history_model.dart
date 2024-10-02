// To parse this JSON data, do
//
//     final assetHistoryModel = assetHistoryModelFromJson(jsonString);

import 'dart:convert';

AssetHistoryModel assetHistoryModelFromJson(Map<String, dynamic> map) =>
    AssetHistoryModel.fromJson(map);

String assetHistoryModelToJson(AssetHistoryModel data) =>
    json.encode(data.toJson());

class AssetHistoryModel {
  AssetHistoryModel({
    this.assetPartsHistory,
  });

  AssetPartsHistory? assetPartsHistory;

  factory AssetHistoryModel.fromJson(Map<String, dynamic> json) =>
      AssetHistoryModel(
        assetPartsHistory: json["assetPartsHistory"] == null
            ? null
            : AssetPartsHistory.fromJson(json["assetPartsHistory"]),
      );

  Map<String, dynamic> toJson() => {
        "assetPartsHistory": assetPartsHistory?.toJson(),
      };
}

class AssetPartsHistory {
  AssetPartsHistory({
    this.items,
    this.totalItems,
    this.totalPages,
    this.pageItemCount,
    this.currentPage,
  });

  List<ItemData>? items;
  int? totalItems;
  int? totalPages;
  int? pageItemCount;
  int? currentPage;

  factory AssetPartsHistory.fromJson(Map<String, dynamic> json) =>
      AssetPartsHistory(
        items: json["items"] == null
            ? []
            : List<ItemData>.from(
                json["items"]!.map((x) => ItemData.fromJson(x))),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        pageItemCount: json["pageItemCount"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItems": totalItems,
        "totalPages": totalPages,
        "pageItemCount": pageItemCount,
        "currentPage": currentPage,
      };
}

class ItemData {
  ItemData({
    this.name,
    this.identifier,
    this.partNumber,
    this.expiryRunhours,
    this.expiryOdometer,
    this.expiryDuration,
    this.fittedDate,
    this.fittedRunhours,
    this.fittedOdometer,
    this.removedDate,
    this.removedRunhours,
    this.removedOdometer,
    this.usedOdometer,
    this.usedRunhours,
    this.usedTime,
  });

  String? name;
  String? identifier;
  String? partNumber;
  int? expiryRunhours;
  double? expiryOdometer;
  dynamic expiryDuration;
  num? fittedDate;
  num? fittedRunhours;
  num? fittedOdometer;
  num? removedDate;
  num? removedRunhours;
  num? removedOdometer;
  num? usedOdometer;
  num? usedRunhours;
  num? usedTime;

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        name: json["name"],
        identifier: json["identifier"],
        partNumber: json["partNumber"],
        expiryRunhours: json["expiryRunhours"],
        expiryOdometer: json["expiryOdometer"]?.toDouble(),
        expiryDuration: json["expiryDuration"],
        fittedDate: json["fittedDate"],
        fittedRunhours: json["fittedRunhours"],
        fittedOdometer: json["fittedOdometer"],
        removedDate: json["removedDate"],
        removedRunhours: json["removedRunhours"],
        removedOdometer: json["removedOdometer"],
        usedOdometer: json["usedOdometer"],
        usedRunhours: json["usedRunhours"],
        usedTime: json["usedTime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "identifier": identifier,
        "partNumber": partNumber,
        "expiryRunhours": expiryRunhours,
        "expiryOdometer": expiryOdometer,
        "expiryDuration": expiryDuration,
        "fittedDate": fittedDate,
        "fittedRunhours": fittedRunhours,
        "fittedOdometer": fittedOdometer,
        "removedDate": removedDate,
        "removedRunhours": removedRunhours,
        "removedOdometer": removedOdometer,
        "usedOdometer": usedOdometer,
        "usedRunhours": usedRunhours,
        "usedTime": usedTime,
      };
}
