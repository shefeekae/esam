// To parse this JSON data, do
//
//     final assetPartsModel = assetPartsModelFromJson(jsonString);

import 'dart:convert';

AssetPartsModel assetPartsModelFromJson(Map<String, dynamic> map) =>
    AssetPartsModel.fromJson(map);

String assetPartsModelToJson(AssetPartsModel data) =>
    json.encode(data.toJson());

class AssetPartsModel {
  AssetPartsModel({
    this.assetPartsLive,
  });

  AssetPartsLive? assetPartsLive;

  factory AssetPartsModel.fromJson(Map<String, dynamic> json) =>
      AssetPartsModel(
        assetPartsLive: json["assetPartsLive"] == null
            ? null
            : AssetPartsLive.fromJson(json["assetPartsLive"]),
      );

  Map<String, dynamic> toJson() => {
        "assetPartsLive": assetPartsLive?.toJson(),
      };
}

class AssetPartsLive {
  AssetPartsLive({
    this.items,
    this.totalItems,
    this.totalPages,
    this.pageItemCount,
    this.currentPage,
  });

  List<Item>? items;
  int? totalItems;
  int? totalPages;
  int? pageItemCount;
  int? currentPage;

  factory AssetPartsLive.fromJson(Map<String, dynamic> json) => AssetPartsLive(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
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

class Item {
  Item({
    this.name,
    this.identifier,
    this.partNumber,
    this.expiryRunhours,
    this.expiryOdometer,
    this.expiryDuration,
    this.remainingOdometer,
    this.remainingRunhours,
    this.remainingTime,
    this.fittedDate,
    this.fittedRunhours,
    this.fittedOdometer,
    this.usedTime,
    this.usedRunhours,
    this.usedOdometer,
    this.totalTime,
    this.totalRunhours,
    this.totalOdometer,
  });

  String? name;
  String? identifier;
  String? partNumber;
  int? expiryRunhours;
  double? expiryOdometer;
  dynamic expiryDuration;
  dynamic remainingOdometer;
  double? remainingRunhours;
  dynamic remainingTime;
  int? fittedDate;
  int? fittedRunhours;
  int? fittedOdometer;
  int? usedTime;
  double? usedRunhours;
  double? usedOdometer;
  dynamic totalTime;
  int? totalRunhours;
  dynamic totalOdometer;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        identifier: json["identifier"],
        partNumber: json["partNumber"],
        expiryRunhours: json["expiryRunhours"],
        expiryOdometer: json["expiryOdometer"]?.toDouble(),
        expiryDuration: json["expiryDuration"],
        remainingOdometer: json["remainingOdometer"],
        remainingRunhours: json["remainingRunhours"]?.toDouble(),
        remainingTime: json["remainingTime"],
        fittedDate: json["fittedDate"],
        fittedRunhours: json["fittedRunhours"],
        fittedOdometer: json["fittedOdometer"],
        usedTime: json["usedTime"],
        usedRunhours: json["usedRunhours"]?.toDouble(),
        usedOdometer: json["usedOdometer"]?.toDouble(),
        totalTime: json["totalTime"],
        totalRunhours: json["totalRunhours"],
        totalOdometer: json["totalOdometer"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "identifier": identifier,
        "partNumber": partNumber,
        "expiryRunhours": expiryRunhours,
        "expiryOdometer": expiryOdometer,
        "expiryDuration": expiryDuration,
        "remainingOdometer": remainingOdometer,
        "remainingRunhours": remainingRunhours,
        "remainingTime": remainingTime,
        "fittedDate": fittedDate,
        "fittedRunhours": fittedRunhours,
        "fittedOdometer": fittedOdometer,
        "usedTime": usedTime,
        "usedRunhours": usedRunhours,
        "usedOdometer": usedOdometer,
        "totalTime": totalTime,
        "totalRunhours": totalRunhours,
        "totalOdometer": totalOdometer,
      };
}

Map<String, dynamic> assetPartsLiveData = {
  "assetPartsLive": {
    "items": [
      {
        "name": "Fuel Filter",
        "identifier": "ac61a9e7-78c0-4dbd-b463-252465db8a0b",
        "partNumber": "90099.BF1280.0000",
        "expiryRunhours": null,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": null,
        "remainingTime": null,
        "fittedDate": 1702724420775,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237101381,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": null,
        "totalOdometer": null
      },
      {
        "name": "Coolant",
        "identifier": "eb37d984-f654-4128-94f0-b93240362c0d",
        "partNumber": "BS6580/91602/Falcon",
        "expiryRunhours": 2000,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": -6049.153882500001,
        "remainingTime": null,
        "fittedDate": 1689582344499,
        "fittedRunhours": 7299,
        "fittedOdometer": null,
        "usedTime": 15119977657,
        "usedRunhours": 8049.153882500001,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 2000,
        "totalOdometer": null
      },
      {
        "name": "Hydraulic Oil",
        "identifier": "d29c31b7-65ee-4696-82ea-f7fcc5e929cc",
        "partNumber": "VG68 [Hyd.Oil]",
        "expiryRunhours": 4000,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": -6496.153882500001,
        "remainingTime": null,
        "fittedDate": 1657742400000,
        "fittedRunhours": 4852,
        "fittedOdometer": null,
        "usedTime": 46981522156,
        "usedRunhours": 10496.1538825,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 4000,
        "totalOdometer": null
      },
      {
        "name": "Fuel Filter",
        "identifier": "cfa0a80e-950f-415d-9ada-14d37ebe8c2a",
        "partNumber": "91180.PL420 [60101101201]",
        "expiryRunhours": 300,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 289.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724420775,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237101381,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 300,
        "totalOdometer": null
      },
      {
        "name": "Engine Oil",
        "identifier": "c325ae33-b492-481f-a47a-aa90755e6455",
        "partNumber": "MOBIL [Eng.Oil] [300.intvl]",
        "expiryRunhours": 300,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 289.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724420775,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237101381,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 300,
        "totalOdometer": null
      },
      {
        "name": "Fuel Filter",
        "identifier": "53a59ed4-1538-4d56-80e0-60373cedb8de",
        "partNumber": "FF42000",
        "expiryRunhours": 300,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 289.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724420775,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237101381,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 300,
        "totalOdometer": null
      },
      {
        "name": "Lube Filter",
        "identifier": "61740e62-29cc-4563-aa2b-30ddba0d6f2d",
        "partNumber": "91180.LF3970 [91PY162[ [3401544]",
        "expiryRunhours": 300,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 289.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724420775,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237101381,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 300,
        "totalOdometer": null
      },
      {
        "name": "Engine Oil",
        "identifier": "fa31bbb2-47ec-4d3f-a855-5d832b3abd23",
        "partNumber": "15W40",
        "expiryRunhours": 300,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 289.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724420775,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237101381,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 300,
        "totalOdometer": null
      },
      {
        "name": "Hydraulic Filter",
        "identifier": "a290f0fb-7229-42fb-89f3-38e0304d480e",
        "partNumber": "0160MG010P [6177]",
        "expiryRunhours": 1000,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 989.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724400667,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237121489,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 1000,
        "totalOdometer": null
      },
      {
        "name": "Gear Oil",
        "identifier": "89fc0d39-4551-4eca-891b-96a788d83f6d",
        "partNumber": "85W140 [GearOil]",
        "expiryRunhours": 1000,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 989.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724400667,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237121489,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 1000,
        "totalOdometer": null
      },
      {
        "name": "Air Filter Inner",
        "identifier": "043b3c4f-05d1-4c39-9bb7-e28abf1a8904",
        "partNumber": "R002041",
        "expiryRunhours": 1000,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 989.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724400667,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237121489,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 1000,
        "totalOdometer": null
      },
      {
        "name": "Air Filter Outer",
        "identifier": "abad7496-6992-4c9f-a518-8487858dfb1d",
        "partNumber": "R002042",
        "expiryRunhours": 1000,
        "expiryOdometer": 40547.53,
        "expiryDuration": null,
        "remainingOdometer": null,
        "remainingRunhours": 989.8461174999993,
        "remainingTime": null,
        "fittedDate": 1702724400667,
        "fittedRunhours": 15338,
        "fittedOdometer": null,
        "usedTime": 2237121489,
        "usedRunhours": 10.153882500000691,
        "usedOdometer": null,
        "totalTime": null,
        "totalRunhours": 1000,
        "totalOdometer": null
      }
    ],
    "totalItems": 12,
    "totalPages": 1,
    "pageItemCount": 1500,
    "currentPage": 0
  }
};
