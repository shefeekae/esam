// To parse this JSON data, do
//
//     final levelBasedEventConsolidation = levelBasedEventConsolidationFromJson(jsonString);

import 'dart:convert';

LevelBasedEventConsolidation levelBasedEventConsolidationFromJson(String str) =>
    LevelBasedEventConsolidation.fromJson(json.decode(str));

String levelBasedEventConsolidationToJson(LevelBasedEventConsolidation data) =>
    json.encode(data.toJson());

class LevelBasedEventConsolidation {
  GetLevelBasedEventConsolidation? getLevelBasedEventConsolidation;

  LevelBasedEventConsolidation({
    this.getLevelBasedEventConsolidation,
  });

  factory LevelBasedEventConsolidation.fromJson(Map<String, dynamic> json) =>
      LevelBasedEventConsolidation(
        getLevelBasedEventConsolidation:
            json["getLevelBasedEventConsolidation"] == null
                ? null
                : GetLevelBasedEventConsolidation.fromJson(
                    json["getLevelBasedEventConsolidation"]),
      );

  Map<String, dynamic> toJson() => {
        "getLevelBasedEventConsolidation":
            getLevelBasedEventConsolidation?.toJson(),
      };
}

class GetLevelBasedEventConsolidation {
  String? level;
  List<EventCount>? eventCounts;

  GetLevelBasedEventConsolidation({
    this.level,
    this.eventCounts,
  });

  factory GetLevelBasedEventConsolidation.fromJson(Map<String, dynamic> json) =>
      GetLevelBasedEventConsolidation(
        level: json["level"],
        eventCounts: json["eventCounts"] == null
            ? []
            : List<EventCount>.from(
                json["eventCounts"]!.map((x) => EventCount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "eventCounts": eventCounts == null
            ? []
            : List<dynamic>.from(eventCounts!.map((x) => x.toJson())),
      };
}

class EventCount {
  List<EquipmentConsolidation>? equipmentConsolidation;
  Entity? entity;
  int? count;

  EventCount({
    this.equipmentConsolidation,
    this.entity,
    this.count,
  });

  factory EventCount.fromJson(Map<String, dynamic> json) => EventCount(
        equipmentConsolidation: json["equipmentConsolidation"] == null
            ? []
            : List<EquipmentConsolidation>.from(json["equipmentConsolidation"]!
                .map((x) => EquipmentConsolidation.fromJson(x))),
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "equipmentConsolidation": equipmentConsolidation == null
            ? []
            : List<dynamic>.from(
                equipmentConsolidation!.map((x) => x.toJson())),
        "entity": entity?.toJson(),
        "count": count,
      };
}

class EquipmentConsolidation {
  String? field;
  int? count;

  EquipmentConsolidation({
    this.field,
    this.count,
  });

  factory EquipmentConsolidation.fromJson(Map<String, dynamic> json) =>
      EquipmentConsolidation(
        field: json["field"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "count": count,
      };
}

class Entity {
  String? type;
  Data? data;

  Entity({
    this.type,
    this.data,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        type: json["type"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
      };
}

class Data {
  String? identifier;
  String? clientId;
  String? offset;
  String? clientName;
  String? typeName;
  String? timeZone;
  String? profileImage;
  String? centrepoint;
  String? createdOn;
  String? homePage;
  String? weatherSensor;
  String? createdBy;
  String? domain;
  String? location;
  String? status;
  String? area;
  String? dataDefault;
  String? displayName;
  String? name;

  Data({
    this.identifier,
    this.clientId,
    this.offset,
    this.clientName,
    this.typeName,
    this.timeZone,
    this.profileImage,
    this.centrepoint,
    this.createdOn,
    this.homePage,
    this.weatherSensor,
    this.createdBy,
    this.domain,
    this.location,
    this.status,
    this.area,
    this.dataDefault,
    this.displayName,
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        identifier: json["identifier"],
        clientId: json["clientId"],
        offset: json["offset"],
        clientName: json["clientName"],
        typeName: json["typeName"],
        timeZone: json["timeZone"],
        profileImage: json["profileImage"],
        centrepoint: json["centrepoint"],
        createdOn: json["createdOn"],
        homePage: json["homePage"],
        weatherSensor: json["weatherSensor"],
        createdBy: json["createdBy"],
        domain: json["domain"],
        location: json["location"],
        status: json["status"],
        area: json["area"],
        dataDefault: json["default"],
        displayName: json['displayName'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "clientId": clientId,
        "offset": offset,
        "clientName": clientName,
        "typeName": typeName,
        "timeZone": timeZone,
        "profileImage": profileImage,
        "centrepoint": centrepoint,
        "createdOn": createdOn,
        "homePage": homePage,
        "weatherSensor": weatherSensor,
        "createdBy": createdBy,
        "domain": domain,
        "location": location,
        "status": status,
        "area": area,
        "default": dataDefault,
      };
}
