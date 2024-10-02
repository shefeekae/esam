// To parse this JSON data, do
//
//     final assetInfoModel = assetInfoModelFromJson(jsonString);

import 'dart:convert';

AssetInfoModel assetInfoModelFromJson(Map<String, dynamic> map) =>
    AssetInfoModel.fromJson(map);

String assetInfoModelToJson(AssetInfoModel data) => json.encode(data.toJson());

class AssetInfoModel {
  AssetInfoModel({
    this.findAsset,
  });

  FindAsset? findAsset;

  factory AssetInfoModel.fromJson(Map<String, dynamic> json) => AssetInfoModel(
        findAsset: json["findAsset"] == null
            ? null
            : FindAsset.fromJson(json["findAsset"]),
      );

  Map<String, dynamic> toJson() => {
        "findAsset": findAsset?.toJson(),
      };
}

class FindAsset {
  FindAsset({
    this.asset,
    this.parent,
    this.assetLatest,
    this.criticalPoints,
    this.lowPriorityPoints,
    this.settings,
    this.device,
    this.sim,
  });

  Asset? asset;
  String? parent;
  AssetLatest? assetLatest;
  List<CriticalPointElement>? criticalPoints;
  List<CriticalPointElement>? lowPriorityPoints;
  Settings? settings;
  Device? device;
  dynamic sim;

  factory FindAsset.fromJson(Map<String, dynamic> json) => FindAsset(
        asset: json["asset"] == null ? null : Asset.fromJson(json["asset"]),
        parent: json["parent"],
        assetLatest: json["assetLatest"] == null
            ? null
            : AssetLatest.fromJson(json["assetLatest"]),
        criticalPoints: json["criticalPoints"] == null
            ? []
            : List<CriticalPointElement>.from(json["criticalPoints"]
                .map((x) => CriticalPointElement.fromJson(x))),
        lowPriorityPoints: json["lowPriorityPoints"] == null
            ? []
            : List<CriticalPointElement>.from(json["lowPriorityPoints"]
                .map((x) => CriticalPointElement.fromJson(x))),
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
        device: json["device"] == null ? null : Device.fromJson(json["device"]),
        sim: json["sim"],
      );

  Map<String, dynamic> toJson() => {
        "asset": asset?.toJson(),
        "parent": parent,
        "assetLatest": assetLatest?.toJson(),
        "criticalPoints": criticalPoints == null
            ? []
            : List<dynamic>.from(criticalPoints!.map((x) => x.toJson())),
        "lowPriorityPoints": lowPriorityPoints == null
            ? []
            : List<dynamic>.from(lowPriorityPoints!.map((x) => x.toJson())),
        "settings": settings?.toJson(),
        "device": device?.toJson(),
        "sim": sim,
      };
}

class Asset {
  Asset({
    this.type,
    this.data,
  });

  String? type;
  AssetData? data;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        type: json["type"],
        data: json["data"] == null ? null : AssetData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
      };
}

class AssetData {
  AssetData({
    this.domain,
    this.name,
    this.identifier,
    this.make,
    this.model,
    this.displayName,
    this.sourceTagPath,
    this.ddLink,
    this.dddLink,
    this.profileImage,
    this.status,
    this.createdOn,
    this.assetCode,
    this.typeName,
  });

  String? domain;
  String? name;
  String? identifier;
  String? make;
  String? model;
  String? displayName;
  dynamic sourceTagPath;
  String? ddLink;
  dynamic dddLink;
  String? profileImage;
  DataStatus? status;
  int? createdOn;
  dynamic assetCode;
  String? typeName;

  factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
        domain: json["domain"],
        name: json["name"],
        identifier: json["identifier"],
        make: json["make"],
        model: json["model"],
        displayName: json["displayName"],
        sourceTagPath: json["sourceTagPath"],
        ddLink: json["ddLink"],
        dddLink: json["dddLink"],
        profileImage: json["profileImage"],
        status: dataStatusValues.map[json["status"]],
        createdOn: json["createdOn"],
        assetCode: json["assetCode"],
        typeName: json["typeName"],
      );

  Map<String, dynamic> toJson() => {
        "domain": domain,
        "name": name,
        "identifier": identifier,
        "make": make,
        "model": model,
        "displayName": displayName,
        "sourceTagPath": sourceTagPath,
        "ddLink": ddLink,
        "dddLink": dddLink,
        "profileImage": profileImage,
        "status": dataStatusValues.reverse[status],
        "createdOn": createdOn,
        "assetCode": assetCode,
        "typeName": typeName,
      };
}

enum DataStatus { ACTIVE }

final dataStatusValues = EnumValues({"ACTIVE": DataStatus.ACTIVE});

class AssetLatest {
  AssetLatest({
    this.name,
    this.clientName,
    this.serialNumber,
    this.dataTime,
    this.underMaintenance,
    this.points,
    this.operationStatus,
    this.path,
    this.location,
  });

  String? name;
  String? clientName;
  dynamic serialNumber;
  int? dataTime;
  bool? underMaintenance;
  List<Point>? points;
  String? operationStatus;
  List<Path>? path;
  String? location;

  factory AssetLatest.fromJson(Map<String, dynamic> json) => AssetLatest(
        name: json["name"],
        clientName: json["clientName"],
        serialNumber: json["serialNumber"],
        dataTime: json["dataTime"],
        underMaintenance: json["underMaintenance"],
        points: json["points"] == null
            ? []
            : List<Point>.from(json["points"]!.map((x) => Point.fromJson(x))),
        operationStatus: json["operationStatus"],
        path: json["path"] == null
            ? []
            : List<Path>.from(json["path"]!.map((x) => Path.fromJson(x))),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "clientName": clientName,
        "serialNumber": serialNumber,
        "dataTime": dataTime,
        "underMaintenance": underMaintenance,
        "points": points == null
            ? []
            : List<dynamic>.from(points!.map((x) => x.toJson())),
        "operationStatus": operationStatus,
        "path": path == null
            ? []
            : List<dynamic>.from(path!.map((x) => x.toJson())),
        "location": location,
      };
}

class Path {
  Path({
    this.name,
    this.entity,
  });

  String? name;
  Entity? entity;

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        name: json["name"],
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "entity": entity?.toJson(),
      };
}

class Entity {
  Entity({
    this.type,
    this.data,
    this.identifier,
    this.domain,
  });

  String? type;
  EntityData? data;
  String? identifier;
  String? domain;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        type: json["type"],
        data: json["data"] == null ? null : EntityData.fromJson(json["data"]),
        identifier: json["identifier"],
        domain: json["domain"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
        "identifier": identifier,
        "domain": domain,
      };
}

class EntityData {
  EntityData({
    this.identifier,
    this.domain,
    this.name,
    this.parentType,
  });

  String? identifier;
  String? domain;
  String? name;
  String? parentType;

  factory EntityData.fromJson(Map<String, dynamic> json) => EntityData(
        identifier: json["identifier"],
        domain: json["domain"],
        name: json["name"],
        parentType: json["parentType"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "domain": domain,
        "name": name,
        "parentType": parentType,
      };
}

class Point {
  Point({
    this.unit,
    this.unitSymbol,
    this.data,
    this.pointName,
    this.pointId,
    this.dataType,
    this.displayName,
    this.type,
    this.status,
    this.pointAccessType,
    this.precedence,
    this.expression,
  });

  String? unit;
  String? unitSymbol;
  dynamic data;
  String? pointName;
  String? pointId;
  DataTypeEnum? dataType;
  String? displayName;
  // PurpleType? type;
  String? type;
  PointStatus? status;
  AccessType? pointAccessType;
  String? precedence;
  String? expression;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        unit: json["unit"],
        unitSymbol: json["unitSymbol"],
        data: json["data"],
        pointName: json["pointName"],
        pointId: json["pointId"],
        dataType: dataTypeEnumValues.map[json["dataType"]],
        displayName: json["displayName"],
        // type: purpleTypeValues.map[json["type"]],
        type: json['type'],
        status: pointStatusValues.map[json["status"]],
        pointAccessType: accessTypeValues.map[json["pointAccessType"]],
        precedence: json["precedence"],
        expression: json["expression"],
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "unitSymbol": unitSymbol,
        "data": data,
        "pointName": pointName,
        "pointId": pointId,
        "dataType": dataTypeEnumValues.reverse[dataType],
        "displayName": displayName,
        "type": purpleTypeValues.reverse[type],
        "status": pointStatusValues.reverse[status],
        "pointAccessType": accessTypeValues.reverse[pointAccessType],
        "precedence": precedence,
        "expression": expression,
      };
}

class DataData {
  DataData({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

enum DataTypeEnum { INTEGER, DOUBLE, STRING, GEOPOINT, BOOLEAN, FLOAT, EMPTY }

final dataTypeEnumValues = EnumValues({
  "Boolean": DataTypeEnum.BOOLEAN,
  "Double": DataTypeEnum.DOUBLE,
  "": DataTypeEnum.EMPTY,
  "Float": DataTypeEnum.FLOAT,
  "Geopoint": DataTypeEnum.GEOPOINT,
  "Integer": DataTypeEnum.INTEGER,
  "String": DataTypeEnum.STRING
});

enum AccessType { READONLY }

final accessTypeValues = EnumValues({"READONLY": AccessType.READONLY});

enum PointStatus { HEALTHY }

final pointStatusValues = EnumValues({"healthy": PointStatus.HEALTHY});

enum PurpleType { INTEGER, DOUBLE, STRING, GEOPOINT, BOOLEAN, FLOAT }

final purpleTypeValues = EnumValues({
  "BOOLEAN": PurpleType.BOOLEAN,
  "DOUBLE": PurpleType.DOUBLE,
  "FLOAT": PurpleType.FLOAT,
  "GEOPOINT": PurpleType.GEOPOINT,
  "INTEGER": PurpleType.INTEGER,
  "STRING": PurpleType.STRING
});

class CriticalPointElement {
  CriticalPointElement({
    this.type,
    this.data,
  });

  CriticalPointType? type;
  CriticalPointData? data;

  factory CriticalPointElement.fromJson(Map<String, dynamic> json) =>
      CriticalPointElement(
        type: criticalPointTypeValues.map[json["type"]],
        data: json["data"] == null
            ? null
            : CriticalPointData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": criticalPointTypeValues.reverse[type],
        "data": data?.toJson(),
      };
}

class CriticalPointData {
  CriticalPointData({
    this.identifier,
    this.expression,
    this.physicalQuantity,
    this.pointName,
    this.displayName,
    this.dataType,
    this.typeName,
    this.type,
    this.remoteDataType,
    this.createdOn,
    this.precedence,
    this.accessType,
    this.unit,
    this.pointId,
    this.createdBy,
    this.domain,
    this.unitSymbol,
    this.status,
    this.possibleValues,
    this.maxValue,
    this.minValue,
  });

  String? identifier;
  String? expression;
  String? physicalQuantity;
  String? pointName;
  String? displayName;
  DataTypeEnum? dataType;
  TypeName? typeName;
  DataTypeEnum? type;
  DataTypeEnum? remoteDataType;
  String? createdOn;
  String? precedence;
  AccessType? accessType;
  String? unit;
  String? pointId;
  CreatedBy? createdBy;
  Domain? domain;
  String? unitSymbol;
  DataStatus? status;
  String? possibleValues;
  String? maxValue;
  String? minValue;

  factory CriticalPointData.fromJson(Map<String, dynamic> json) =>
      CriticalPointData(
        identifier: json["identifier"],
        expression: json["expression"],
        physicalQuantity: json["physicalQuantity"],
        pointName: json["pointName"],
        displayName: json["displayName"],
        dataType: dataTypeEnumValues.map[json["dataType"]],
        typeName: typeNameValues.map[json["typeName"]],
        type: dataTypeEnumValues.map[json["type"]],
        remoteDataType: dataTypeEnumValues.map[json["remoteDataType"]],
        createdOn: json["createdOn"],
        precedence: json["precedence"],
        accessType: accessTypeValues.map[json["accessType"]],
        unit: json["unit"],
        pointId: json["pointId"],
        createdBy: createdByValues.map[json["createdBy"]],
        domain: domainValues.map[json["domain"]],
        unitSymbol: json["unitSymbol"],
        status: dataStatusValues.map[json["status"]],
        possibleValues: json["possibleValues"],
        maxValue: json["maxValue"],
        minValue: json["minValue"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "expression": expression,
        "physicalQuantity": physicalQuantity,
        "pointName": pointName,
        "displayName": displayName,
        "dataType": dataTypeEnumValues.reverse[dataType],
        "typeName": typeNameValues.reverse[typeName],
        "type": dataTypeEnumValues.reverse[type],
        "remoteDataType": dataTypeEnumValues.reverse[remoteDataType],
        "createdOn": createdOn,
        "precedence": precedence,
        "accessType": accessTypeValues.reverse[accessType],
        "unit": unit,
        "pointId": pointId,
        "createdBy": createdByValues.reverse[createdBy],
        "domain": domainValues.reverse[domain],
        "unitSymbol": unitSymbol,
        "status": dataStatusValues.reverse[status],
        "possibleValues": possibleValues,
        "maxValue": maxValue,
        "minValue": minValue,
      };
}

enum CreatedBy { RIYAS_NECTARIT }

final createdByValues =
    EnumValues({"riyas@nectarit": CreatedBy.RIYAS_NECTARIT});

enum Domain { NECTARIT }

final domainValues = EnumValues({"nectarit": Domain.NECTARIT});

enum TypeName { CONFIG_POINT }

final typeNameValues = EnumValues({"Config Point": TypeName.CONFIG_POINT});

enum CriticalPointType { CONFIG_POINT }

final criticalPointTypeValues =
    EnumValues({"ConfigPoint": CriticalPointType.CONFIG_POINT});

class Device {
  Device({
    this.type,
    this.data,
  });

  String? type;
  DeviceData? data;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        type: json["type"],
        data: json["data"] == null ? null : DeviceData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
      };
}

class DeviceData {
  DeviceData({
    this.sourceId,
    this.deviceIp,
    this.ownerClientId,
    this.configuration,
    this.latitude,
    this.typeName,
    this.slot,
    this.deviceName,
    this.createdOn,
    this.protocol,
    this.password,
    this.ownerName,
    this.model,
    this.datasourceName,
    this.distributedOn,
    this.make,
    this.longitude,
    this.allocated,
    this.deviceType,
    this.identifier,
    this.serialNumber,
    this.writebackPort,
    this.timeZone,
    this.userName,
    this.version,
    this.url,
    this.tags,
    this.createdBy,
    this.publish,
    this.domain,
    this.devicePort,
    this.networkProtocol,
    this.status,
  });

  String? sourceId;
  String? deviceIp;
  String? ownerClientId;
  String? configuration;
  String? latitude;
  String? typeName;
  String? slot;
  String? deviceName;
  String? createdOn;
  String? protocol;
  String? password;
  String? ownerName;
  String? model;
  String? datasourceName;
  int? distributedOn;
  String? make;
  String? longitude;
  String? allocated;
  String? deviceType;
  String? identifier;
  String? serialNumber;
  String? writebackPort;
  String? timeZone;
  String? userName;
  String? version;
  String? url;
  String? tags;
  String? createdBy;
  String? publish;
  Domain? domain;
  String? devicePort;
  String? networkProtocol;
  DataStatus? status;

  factory DeviceData.fromJson(Map<String, dynamic> json) => DeviceData(
        sourceId: json["sourceId"],
        deviceIp: json["deviceIp"],
        ownerClientId: json["ownerClientId"],
        configuration: json["configuration"],
        latitude: json["latitude"],
        typeName: json["typeName"],
        slot: json["slot"],
        deviceName: json["deviceName"],
        createdOn: json["createdOn"],
        protocol: json["protocol"],
        password: json["password"],
        ownerName: json["ownerName"],
        model: json["model"],
        datasourceName: json["datasourceName"],
        distributedOn: json["distributedOn"],
        make: json["make"],
        longitude: json["longitude"],
        allocated: json["allocated"],
        deviceType: json["deviceType"],
        identifier: json["identifier"],
        serialNumber: json["serialNumber"],
        writebackPort: json["writebackPort"],
        timeZone: json["timeZone"],
        userName: json["userName"],
        version: json["version"],
        url: json["url"],
        tags: json["tags"],
        createdBy: json["createdBy"],
        publish: json["publish"],
        domain: domainValues.map[json["domain"]],
        devicePort: json["devicePort"],
        networkProtocol: json["networkProtocol"],
        status: dataStatusValues.map[json["status"]],
      );

  Map<String, dynamic> toJson() => {
        "sourceId": sourceId,
        "deviceIp": deviceIp,
        "ownerClientId": ownerClientId,
        "configuration": configuration,
        "latitude": latitude,
        "typeName": typeName,
        "slot": slot,
        "deviceName": deviceName,
        "createdOn": createdOn,
        "protocol": protocol,
        "password": password,
        "ownerName": ownerName,
        "model": model,
        "datasourceName": datasourceName,
        "distributedOn": distributedOn,
        "make": make,
        "longitude": longitude,
        "allocated": allocated,
        "deviceType": deviceType,
        "identifier": identifier,
        "serialNumber": serialNumber,
        "writebackPort": writebackPort,
        "timeZone": timeZone,
        "userName": userName,
        "version": version,
        "url": url,
        "tags": tags,
        "createdBy": createdBy,
        "publish": publish,
        "domain": domainValues.reverse[domain],
        "devicePort": devicePort,
        "networkProtocol": networkProtocol,
        "status": dataStatusValues.reverse[status],
      };
}

class Settings {
  Settings({
    this.identifier,
    this.actualRunhours,
    this.effectiveRunHours,
    this.expectedRunHours,
    this.odometer,
    this.odometerDailyAvg,
    this.runhours,
    this.runhoursDailyAvg,
    this.runhoursKey,
    this.totalFuelUsed,
    this.updateTime,
  });

  String? identifier;
  int? actualRunhours;
  double? effectiveRunHours;
  double? expectedRunHours;
  double? odometer;
  double? odometerDailyAvg;
  double? runhours;
  double? runhoursDailyAvg;
  String? runhoursKey;
  num? totalFuelUsed;
  int? updateTime;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        identifier: json["identifier"],
        actualRunhours: json["actualRunhours"],
        effectiveRunHours: json["effectiveRunHours"]?.toDouble(),
        expectedRunHours: json["expectedRunHours"],
        odometer: json["odometer"]?.toDouble(),
        odometerDailyAvg: json["odometerDailyAvg"]?.toDouble(),
        runhours: json["runhours"]?.toDouble(),
        runhoursDailyAvg: json["runhoursDailyAvg"]?.toDouble(),
        runhoursKey: json["runhoursKey"],
        totalFuelUsed: json["totalFuelUsed"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "actualRunhours": actualRunhours,
        "effectiveRunHours": effectiveRunHours,
        "expectedRunHours": expectedRunHours,
        "odometer": odometer,
        "odometerDailyAvg": odometerDailyAvg,
        "runhours": runhours,
        "runhoursDailyAvg": runhoursDailyAvg,
        "runhoursKey": runhoursKey,
        "totalFuelUsed": totalFuelUsed,
        "updateTime": updateTime,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// Map<String, dynamic> findAssetData = {
//   "findAsset": {
//     "asset": {
//       "type": "LonkingWheelLoaderCDM856",
//       "data": {
//         "domain": "gge",
//         "name": "WL003",
//         "identifier": "790b1363-bdd8-4cc2-9368-4aa1de7e6bd5",
//         "make": "Lonking",
//         "model": "CDM856",
//         "displayName": "WL003",
//         "sourceTagPath": null,
//         "ddLink": "",
//         "dddLink": null,
//         "profileImage": "",
//         "status": "ACTIVE",
//         "createdOn": 1657700680892,
//         "assetCode": null,
//         "typeName": "Lonking Wheel Loader CDM856",
//         "ownerClientId": "alsafa"
//       }
//     },
//     "parent": "HeavyMachine",
//     "assetLatest": {
//       "name": "WL003",
//       "clientName": "Al Safa",
//       "serialNumber": "C09275",
//       "dataTime": 1704975918000,
//       "underMaintenance": true,
//       "points": [
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": "Active",
//           "pointName": "Reverse",
//           "pointId": "Reverse",
//           "dataType": "String",
//           "displayName": "Reverse",
//           "type": "STRING",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09Reverse%3B%0A%09Reverse%3Dconvert%3AconvertToDecimal%28DIN2%29%3D%3D0%3F%27Active%27%3A%27In%20Active%27%3B%0A%09Reverse%3B%0A%7D"
//         },
//         {
//           "unit": "kilometer",
//           "unitSymbol": "km",
//           "data": 25,
//           "pointName": "Altitude",
//           "pointId": "Altitude",
//           "dataType": "Double",
//           "displayName": "Altitude",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09altitude%3B%0A%09altitude%3Dconvert%3AconvertToDecimal%28Altitude%29%3B%0A%09altitude%3D%28altitude%20%2B%20math%3Apow%282%2C%2015%29%29%20%25%20math%3Apow%282%2C%2016%29%3B%0A%09altitude%20%3D%20altitude%20-%20math%3Apow%282%2C%2015%29%3B%0A%09altitude%3Dnumber%3AformatDouble%28altitude%2C2%29%3B%0A%09altitude%3B%0A%7D"
//         },
//         {
//           "unit": "kilometer per hour",
//           "unitSymbol": "km/hr",
//           "data": 0,
//           "pointName": "Speed",
//           "pointId": "Speed",
//           "dataType": "Double",
//           "displayName": "Speed",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7Bspeed%3Bspeed%3Dconvert%3AconvertToLong%28Speed%29%3Bspeed%7D"
//         },
//         {
//           "unit": "volt",
//           "unitSymbol": "V",
//           "data": 27.17,
//           "pointName": "Vehicle Battery",
//           "pointId": "Vehicle Battery",
//           "dataType": "Double",
//           "displayName": "Vehicle Battery",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09vehBat%3B%0A%09vehBat%3Dconvert%3AconvertToLong%28ExternalPowerVoltage%29%2F1000.00%3B%0A%09vehBat%3Dnumber%3AformatDouble%28vehBat%2C2%29%3B%0A%09vehBat%3B%0A%7D"
//         },
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": 16,
//           "pointName": "Visible Satellites",
//           "pointId": "Visible Satellites",
//           "dataType": "Integer",
//           "displayName": "Visible Satellites",
//           "type": "INTEGER",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09gps%3B%0A%09gps%3Dconvert%3AconvertToLong%28VisibleSatellites%29%3B%0A%09gps%3B%0A%7D"
//         },
//         {
//           "unit": "steradian",
//           "unitSymbol": "sr",
//           "data": 109,
//           "pointName": "Angle",
//           "pointId": "Angle",
//           "dataType": "Double",
//           "displayName": "Angle",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09angle%3B%0A%09angle%3Dconvert%3AconvertToLong%28Angle%29%3B%0A%09angle%3B%0A%7D"
//         },
//         {
//           "unit": "volt",
//           "unitSymbol": "V",
//           "data": 4.07,
//           "pointName": "Device Battery",
//           "pointId": "Device Battery",
//           "dataType": "Double",
//           "displayName": "Device Battery",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09deviceBattery%3B%0A%09deviceBattery%3Dconvert%3AconvertToLong%28InternalBatteryVoltage%29%2F1000.00%3B%0A%09deviceBattery%3Dnumber%3AformatDouble%28deviceBattery%2C2%29%3B%0A%09deviceBattery%3B%0A%7D"
//         },
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": 5,
//           "pointName": "GSM Signal",
//           "pointId": "GSM Signal",
//           "dataType": "Integer",
//           "displayName": "GSM Signal",
//           "type": "INTEGER",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09gsm%3B%0A%09gsm%3Dconvert%3AconvertToLong%28GSMSignal%29%3B%0A%09gsm%3B%0A%7D"
//         },
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": "ON",
//           "pointName": "Engine Status",
//           "pointId": "Engine Status",
//           "dataType": "String",
//           "displayName": "Engine Status",
//           "type": "STRING",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "1",
//           "expression":
//               "%24%7B%0A%09EngineStatus%3B%0A%09EngineStatus%3Dconvert%3AconvertToDecimal%28DIN1%29%3D%3D1%3F%27ON%27%3A%27OFF%27%3B%0A%09EngineStatus%3B%0A%7D"
//         },
//         {
//           "unit": "liter",
//           "unitSymbol": "L",
//           "data": 191.41475763074556,
//           "pointName": "Fuel Level",
//           "pointId": "Fuel Level",
//           "dataType": "Double",
//           "displayName": "Fuel Level",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "2",
//           "expression":
//               "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%0Afl%20%3D%20convert%3AconvertToDecimal%28DallasTemperature5%29%3B%0Aif%28fl%20%3E1909%20%7C%7C%20fl%20%3C%20230%29%20return%20null%3B%0Aflf%3D-26.4%2B0.217%2afl-2.73E-04%2amath%3Apow%28fl%2C2%29%2B2.07E-07%2amath%3Apow%28fl%2C3%29-4.29E-11%2amath%3Apow%28fl%2C4%29%3B%0Aif%28flf%20%3C%200%29%20return%200.0%3B%0Aif%28flf%20%3E%20270%29%20return%20270.00%3B%0Areturn%20flf%3B%7D"
//         },
//         {
//           "unit": "metre",
//           "unitSymbol": "m",
//           "data": 13895,
//           "pointName": "Distance Travelled",
//           "pointId": "Distance Travelled",
//           "dataType": "Double",
//           "displayName": "Distance Travelled",
//           "type": "DOUBLE",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "2",
//           "expression":
//               "%24%7Bvir_odo%3B%0Aif%28TripOdometer%3D%3Dnull%29%20return%20number%3AreturnNaN%28%29%3B%0Avir_odo%3Dconvert%3AconvertToDecimal%28TripOdometer%29%3B%0Avir_odo%3B%0A%7D"
//         },
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": {"latitude": 25.025671, "longitude": 55.126392},
//           "pointName": "Location",
//           "pointId": "Location",
//           "dataType": "Geopoint",
//           "displayName": "Location",
//           "type": "GEOPOINT",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "2",
//           "expression":
//               "%24%7B%0Alocation%3D%5B%5D%3B%0Alat%3BlatData%3B%0Alng%3BlngData%3B%0Alat%3Dconvert%3AconvertToBinary%28Latitude.substring%280%2C2%29%29%3B%0Alat%3Dlat.substring%280%2C1%29%3B%0Aif%28lat%20eq%201%29%20%0AlatData%20%3D%20convert%3AgetTwosComplement%28Latitude%29%2F10000000.00%3B%0Aelse%20%0AlatData%20%3Dconvert%3AconvertToLong%28Latitude%29%2F10000000.00%3B%0A%0Alng%3Dconvert%3AconvertToBinary%28Longitude.substring%280%2C2%29%29%3B%0Alng%3Dlng.substring%280%2C1%29%3B%0Aif%28lng%20eq%201%29%20%0AlngData%20%3D%20convert%3AgetTwosComplement%28Longitude%29%2F10000000.00%3B%0Aelse%20%0AlngData%20%3Dconvert%3AconvertToLong%28Longitude%29%2F10000000.00%3B%0A%0Alocation%3D%5BlatData%2ClngData%5D%3B%0Alocation%3B%0A%7D"
//         },
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": "E",
//           "pointName": "Direction",
//           "pointId": "Direction",
//           "dataType": "String",
//           "displayName": "Direction",
//           "type": "STRING",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "2",
//           "expression":
//               "%24%7B%0A%20%20%20%20%20%20%20%20direction%3Bangle%3B%0A%20%20%20%20%20%20%20%20angle%3DAngle%3B%0A%20%0A%20%20%20%20%20%20%20if%28angle%20ge%20337.5%20or%20angle%20lt%2022.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27N%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2022.5%20and%20angle%20lt%2067.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NE%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2067.5%20%20and%20angle%20lt%20112.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27E%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20112.5%20and%20angle%20lt%20157.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SE%27%3B%20%20%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20157.5%20and%20angle%20lt%20202.5%29%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27S%27%3B%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20202.5%20and%20angle%20lt%20247.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SW%27%3B%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20247.5%20and%20angle%20lt%20292.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27W%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20292.5%20and%20angle%20lt%20337.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NW%27%3B%0A%20%0A%20%20%20%20%20%20%20direction%3B%0A%7D"
//         },
//         {
//           "unit": "percent",
//           "unitSymbol": "%",
//           "data": 70.894356,
//           "pointName": "Fuel Remaining",
//           "pointId": "Fuel Remaining",
//           "dataType": "Float",
//           "displayName": "Fuel Remaining",
//           "type": "FLOAT",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "3",
//           "expression":
//               "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%0Aif%28FuelLevel%20%3E%20270%20%7C%7C%20FuelLevel%20%3C%200%29%20return%20null%3B%0Areturn%20%28FuelLevel%2F270%29%2a100%3B%7D"
//         },
//         {
//           "unit": "unitless",
//           "unitSymbol": "-",
//           "data": "On",
//           "pointName": "Motion Status",
//           "pointId": "Motion Status",
//           "dataType": "String",
//           "displayName": "Motion Status",
//           "type": "STRING",
//           "status": "healthy",
//           "pointAccessType": "READONLY",
//           "precedence": "3",
//           "expression":
//               "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20%27Off%27%3B%0Aif%28EngineStatus%20eq%20%27ON%27%29%20return%20%27On%27%3B%7D"
//         }
//       ],
//       "operationStatus": "On",
//       "path": [
//         {
//           "name": "Al Safa",
//           "entity": {
//             "type": "Customer",
//             "data": {
//               "identifier": "alsafa",
//               "domain": "ggesharjah",
//               "name": "Al Safa",
//               "parentType": "Community"
//             },
//             "identifier": "alsafa",
//             "domain": "ggesharjah"
//           }
//         },
//         {
//           "name": "WL003",
//           "entity": {
//             "type": "LonkingWheelLoaderCDM856",
//             "data": {
//               "identifier": "790b1363-bdd8-4cc2-9368-4aa1de7e6bd5",
//               "domain": "gge",
//               "name": "WL003",
//               "parentType": "Equipment"
//             },
//             "identifier": "790b1363-bdd8-4cc2-9368-4aa1de7e6bd5",
//             "domain": "gge"
//           }
//         }
//       ],
//       "location": "POINT(55.1263933 25.0256716)"
//     },
//     "criticalPoints": [
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "fd22ffc1-4bc4-4e93-be9f-45375dcfbb57",
//           "expression":
//               "%24%7Bconvert%3AconvertToDecimal%28DallasTemperature5%29%7D",
//           "physicalQuantity": "electric potential",
//           "pointName": "Fuel Data",
//           "maxValue": "",
//           "displayName": "Fuel Data",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 46,
//           "type": "",
//           "remoteDataType": "Float",
//           "createdOn": "1655269590822",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "millivolt",
//           "minValue": "",
//           "pointId": "Fuel Data",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "mV",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "dbee110d-85b1-46a9-828b-f5e3b03ce717",
//           "expression":
//               "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%0Afl%20%3D%20convert%3AconvertToDecimal%28DallasTemperature5%29%3B%0Aif%28fl%20%3E1909%20%7C%7C%20fl%20%3C%20230%29%20return%20null%3B%0Aflf%3D89.3%20%2B%2013.6%2afl%20%2B%20-0.0382%2amath%3Apow%28fl%2C2%29%20%2B%204.79E-05%2amath%3Apow%28fl%2C3%29%3B%0Aif%28flf%20%3C%200%29%20return%200.0%3B%0Aif%28flf%20%3E%20270%29%20return%20270.00%3B%0Areturn%20flf%3B%7D",
//           "physicalQuantity": "volume",
//           "pointName": "Fuel Level",
//           "maxValue": "",
//           "displayName": "Fuel Level",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 21,
//           "remoteDataType": "",
//           "type": "",
//           "createdOn": "1655269590822",
//           "precedence": "2",
//           "accessType": "READONLY",
//           "unit": "liter",
//           "minValue": "",
//           "pointId": "Fuel Level",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "L",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "4a283062-c8ce-4311-b7f5-556e3a183c83",
//           "expression":
//               "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%0Aif%28FuelLevel%20%3E%20270%20%7C%7C%20FuelLevel%20%3C%200%29%20return%20null%3B%0Areturn%20%28FuelLevel%2F270%29%2a100%3B%7D",
//           "physicalQuantity": "percentage",
//           "pointName": "Fuel Remaining",
//           "maxValue": "",
//           "displayName": "Fuel Remaining",
//           "dataType": "Float",
//           "typeName": "Config Point",
//           "pid": 45,
//           "remoteDataType": "",
//           "type": "",
//           "createdOn": "1655269590822",
//           "precedence": "3",
//           "accessType": "READONLY",
//           "unit": "percent",
//           "minValue": "",
//           "pointId": "Fuel Remaining",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "%",
//           "status": "ACTIVE"
//         }
//       }
//     ],
//     "lowPriorityPoints": [
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "56380125-81b2-410b-bde8-425312b46f4b",
//           "expression":
//               "%24%7Bvir_odo%3B%0Aif%28TripOdometer%3D%3Dnull%29%20return%20number%3AreturnNaN%28%29%3B%0Avir_odo%3Dconvert%3AconvertToDecimal%28TripOdometer%29%3B%0Avir_odo%3B%0A%7D",
//           "physicalQuantity": "length",
//           "pointName": "Distance Travelled",
//           "maxValue": "",
//           "displayName": "Distance Travelled",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 31,
//           "type": "Double",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "2",
//           "accessType": "READONLY",
//           "unit": "metre",
//           "minValue": "",
//           "pointId": "Distance Travelled",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "m",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "fd22ffc1-4bc4-4e93-be9f-45375dcfbb57",
//           "expression":
//               "%24%7Bconvert%3AconvertToDecimal%28DallasTemperature5%29%7D",
//           "physicalQuantity": "electric potential",
//           "pointName": "Fuel Data",
//           "maxValue": "",
//           "displayName": "Fuel Data",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 46,
//           "type": "",
//           "remoteDataType": "Float",
//           "createdOn": "1655269590822",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "millivolt",
//           "minValue": "",
//           "pointId": "Fuel Data",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "mV",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "b320b551-766e-40cf-9a2a-03f08f5e7327",
//           "expression":
//               "%24%7B%0A%09angle%3B%0A%09angle%3Dconvert%3AconvertToLong%28Angle%29%3B%0A%09angle%3B%0A%7D",
//           "physicalQuantity": "solid angle",
//           "pointName": "Angle",
//           "maxValue": "",
//           "displayName": "Angle",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 26,
//           "type": "Double",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "steradian",
//           "minValue": "",
//           "pointId": "Angle",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "sr",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "8f2fc500-246d-4be0-bd97-f45dc10a94db",
//           "expression":
//               "%24%7B%0A%09altitude%3B%0A%09altitude%3Dconvert%3AconvertToDecimal%28Altitude%29%3B%0A%09altitude%3D%28altitude%20%2B%20math%3Apow%282%2C%2015%29%29%20%25%20math%3Apow%282%2C%2016%29%3B%0A%09altitude%20%3D%20altitude%20-%20math%3Apow%282%2C%2015%29%3B%0A%09altitude%3Dnumber%3AformatDouble%28altitude%2C2%29%3B%0A%09altitude%3B%0A%7D",
//           "physicalQuantity": "length",
//           "pointName": "Altitude",
//           "maxValue": "",
//           "displayName": "Altitude",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 24,
//           "type": "Double",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "kilometer",
//           "minValue": "",
//           "pointId": "Altitude",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "km",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "a95bf275-8643-470f-9b2c-c612a9abba96",
//           "expression":
//               "%24%7B%0A%09gps%3B%0A%09gps%3Dconvert%3AconvertToLong%28VisibleSatellites%29%3B%0A%09gps%3B%0A%7D",
//           "physicalQuantity": "status integer",
//           "pointName": "Visible Satellites",
//           "maxValue": "",
//           "displayName": "Visible Satellites",
//           "dataType": "Integer",
//           "typeName": "Config Point",
//           "pid": 1,
//           "type": "Integer",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "unitless",
//           "minValue": "",
//           "pointId": "Visible Satellites",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "-",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "a4294ecd-6647-44ea-b5d2-a25a68ba3ccc",
//           "expression":
//               "%24%7B%0A%09gsm%3B%0A%09gsm%3Dconvert%3AconvertToLong%28GSMSignal%29%3B%0A%09gsm%3B%0A%7D",
//           "physicalQuantity": "status integer",
//           "pointName": "GSM Signal",
//           "maxValue": "",
//           "displayName": "GSM Signal",
//           "dataType": "Integer",
//           "typeName": "Config Point",
//           "pid": 20,
//           "type": "Integer",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "unitless",
//           "minValue": "",
//           "pointId": "GSM Signal",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "-",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "810c4364-9385-47ef-bd57-2fae02107ec1",
//           "expression":
//               "%24%7B%0A%09deviceBattery%3B%0A%09deviceBattery%3Dconvert%3AconvertToLong%28InternalBatteryVoltage%29%2F1000.00%3B%0A%09deviceBattery%3Dnumber%3AformatDouble%28deviceBattery%2C2%29%3B%0A%09deviceBattery%3B%0A%7D",
//           "physicalQuantity": "electric potential",
//           "pointName": "Device Battery",
//           "maxValue": "",
//           "displayName": "Device Battery",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 29,
//           "type": "Double",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "volt",
//           "minValue": "",
//           "pointId": "Device Battery",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "V",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "52c8e584-a6a5-40ee-881f-17f2da58c174",
//           "expression":
//               "%24%7Bspeed%3Bspeed%3Dconvert%3AconvertToLong%28Speed%29%3Bspeed%7D",
//           "physicalQuantity": "velocity",
//           "pointName": "Speed",
//           "maxValue": "",
//           "displayName": "Speed",
//           "dataType": "Double",
//           "typeName": "Config Point",
//           "pid": 5,
//           "type": "Double",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "1",
//           "accessType": "READONLY",
//           "unit": "kilometer per hour",
//           "minValue": "",
//           "pointId": "Speed",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "km/hr",
//           "status": "ACTIVE"
//         }
//       },
//       {
//         "type": "ConfigPoint",
//         "data": {
//           "possibleValues": "",
//           "identifier": "ed553cae-0cdb-4ef8-becc-534d75c18fc0",
//           "expression":
//               "%24%7B%0A%20%20%20%20%20%20%20%20direction%3Bangle%3B%0A%20%20%20%20%20%20%20%20angle%3DAngle%3B%0A%20%0A%20%20%20%20%20%20%20if%28angle%20ge%20337.5%20or%20angle%20lt%2022.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27N%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2022.5%20and%20angle%20lt%2067.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NE%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2067.5%20%20and%20angle%20lt%20112.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27E%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20112.5%20and%20angle%20lt%20157.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SE%27%3B%20%20%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20157.5%20and%20angle%20lt%20202.5%29%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27S%27%3B%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20202.5%20and%20angle%20lt%20247.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SW%27%3B%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20247.5%20and%20angle%20lt%20292.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27W%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20292.5%20and%20angle%20lt%20337.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NW%27%3B%0A%20%0A%20%20%20%20%20%20%20direction%3B%0A%7D",
//           "physicalQuantity": "status string",
//           "pointName": "Direction",
//           "maxValue": "",
//           "displayName": "Direction",
//           "dataType": "String",
//           "typeName": "Config Point",
//           "pid": 30,
//           "type": "String",
//           "remoteDataType": "",
//           "createdOn": "1653376224979",
//           "precedence": "2",
//           "accessType": "READONLY",
//           "unit": "unitless",
//           "minValue": "",
//           "pointId": "Direction",
//           "createdBy": "riyas@nectarit",
//           "domain": "nectarit",
//           "unitSymbol": "-",
//           "status": "ACTIVE"
//         }
//       }
//     ],
//     "settings": {
//       "identifier": "bd105033-f397-44e4-9be2-bc2aba18909b",
//       "effectiveRunHours": 15348.1538825,
//       "odometer": 40547.53,
//       "odometerDailyAvg": 0.027142857142857153,
//       "runhours": 15348.1538825,
//       "runhoursDailyAvg": 0.6838486507936508,
//       "runhoursKey": "runhours",
//       "fuelkey": "NULL",
//       "totalFuelUsed": 105198.42876201436,
//       "updateTime": 1704671999999,
//       "status": "ACTIVE"
//     },
//     "device": {
//       "type": "Device",
//       "data": {
//         "sourceId": "866907057695321",
//         "deviceIp": "",
//         "configuration": "",
//         "latitude": "",
//         "typeName": "Device",
//         "slot": "",
//         "deviceName": "866907057695321",
//         "createdOn": "1657700679785",
//         "protocol": "FMB640",
//         "password": "",
//         "model": "FMS",
//         "datasourceName": "866907057695321",
//         "make": "Teltonika",
//         "longitude": "",
//         "allocated": "",
//         "deviceType": "Telematics",
//         "identifier": "87b96061-d72b-447a-98d1-213d66e5ab25",
//         "serialNumber": "866907057695321",
//         "writebackPort": "",
//         "timeZone": "",
//         "userName": "",
//         "version": "V0.07_8",
//         "url": "",
//         "tags": "",
//         "createdBy": "system@nectarit",
//         "publish": "true",
//         "domain": "nectarit",
//         "devicePort": "",
//         "networkProtocol": "TCP",
//         "status": "ACTIVE"
//       }
//     },
//     "sim": null
//   }
// };
