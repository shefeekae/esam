// To parse this JSON data, do
//
//     final alarmDetailsModel = alarmDetailsModelFromJson(jsonString);

import 'dart:convert';

AlarmDetailsModel alarmDetailsModelFromJson(Map<String, dynamic> map) =>
    AlarmDetailsModel.fromJson(map);

String alarmDetailsModelToJson(AlarmDetailsModel data) =>
    json.encode(data.toJson());

class AlarmDetailsModel {
  AlarmDetailsModel({
    this.getEventDetails,
  });

  GetEventDetails? getEventDetails;

  factory AlarmDetailsModel.fromJson(Map<String, dynamic> json) =>
      AlarmDetailsModel(
        getEventDetails: json["getEventDetails"] == null
            ? null
            : GetEventDetails.fromJson(json["getEventDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "getEventDetails": getEventDetails?.toJson(),
      };
}

class GetEventDetails {
  GetEventDetails({
    this.event,
    this.latest,
  });

  Event? event;
  Latest? latest;

  factory GetEventDetails.fromJson(Map<String, dynamic> json) =>
      GetEventDetails(
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        latest: json["latest"] == null ? null : Latest.fromJson(json["latest"]),
      );

  Map<String, dynamic> toJson() => {
        "event": event?.toJson(),
        "latest": latest?.toJson(),
      };
}

class Event {
  Event({
    this.name,
    this.group,
    this.criticality,
    this.sourceId,
    this.sourceType,
    this.sourceName,
    this.eventTime,
    this.eventDay,
    this.resolvedTime,
    this.duration,
    this.activeMessage,
    this.resolveMessage,
    this.suspectData,
    this.active,
    this.recurring,
    this.resolved,
    this.eventId,
    this.acknowledged,
    this.sourceDomain,
    this.eventDomain,
    this.clientDomain,
    this.clientName,
    this.location,
    this.actionRequired,
    this.actioned,
    this.sourceTagPath,
    this.configurationId,
    this.delay,
    this.sourceTypeName,
    this.type,
    this.workOrderId,
    this.workOrderNumber,
  });

  String? name;
  String? group;
  String? type;
  String? criticality;
  String? sourceId;
  String? sourceType;
  String? sourceName;
  int? eventTime;
  int? eventDay;
  int? resolvedTime;
  int? duration;
  String? activeMessage;
  String? resolveMessage;
  String? suspectData;
  bool? active;
  bool? recurring;
  bool? resolved;
  String? eventId;
  bool? acknowledged;
  String? sourceDomain;
  String? eventDomain;
  String? clientDomain;
  String? clientName;
  String? location;
  bool? actionRequired;
  bool? actioned;
  String? sourceTagPath;
  String? configurationId;
  int? delay;
  String? sourceTypeName;
  String? workOrderNumber;
  String? workOrderId;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json["name"],
      group: json["group"],
      criticality: json["criticality"],
      sourceId: json["sourceId"],
      sourceType: json["sourceType"],
      sourceName: json["sourceName"],
      eventTime: json["eventTime"],
      eventDay: json["eventDay"],
      resolvedTime: json["resolvedTime"],
      duration: json["duration"],
      activeMessage: json["activeMessage"],
      resolveMessage: json["resolveMessage"],
      suspectData: json["suspectData"],
      active: json["active"],
      recurring: json["recurring"],
      resolved: json["resolved"],
      eventId: json["eventId"],
      acknowledged: json["acknowledged"],
      sourceDomain: json["sourceDomain"],
      eventDomain: json["eventDomain"],
      clientDomain: json["clientDomain"],
      clientName: json["clientName"],
      location: json["location"],
      actionRequired: json["actionRequired"],
      actioned: json["actioned"],
      sourceTagPath: json["sourceTagPath"],
      configurationId: json["configurationId"],
      delay: json["delay"],
      sourceTypeName: json["sourceTypeName"],
      type: json['type'],
      workOrderId: json['workOrderId'],
      workOrderNumber: json['workOrderNo'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "group": group,
        "criticality": criticality,
        "sourceId": sourceId,
        "sourceType": sourceType,
        "sourceName": sourceName,
        "eventTime": eventTime,
        "eventDay": eventDay,
        "resolvedTime": resolvedTime,
        "duration": duration,
        "activeMessage": activeMessage,
        "resolveMessage": resolveMessage,
        "suspectData": suspectData,
        "active": active,
        "recurring": recurring,
        "resolved": resolved,
        "eventId": eventId,
        "acknowledged": acknowledged,
        "sourceDomain": sourceDomain,
        "eventDomain": eventDomain,
        "clientDomain": clientDomain,
        "clientName": clientName,
        "location": location,
        "actionRequired": actionRequired,
        "actioned": actioned,
        "sourceTagPath": sourceTagPath,
        "configurationId": configurationId,
        "delay": delay,
        "sourceTypeName": sourceTypeName,
        "workOrderNo": workOrderNumber,
        "workOrderId": workOrderId,
      };
}

class Latest {
  Latest({
    this.identifier,
    this.clientDomain,
    this.clientName,
    this.domain,
    this.id,
    this.name,
    this.displayName,
    this.make,
    this.model,
    this.type,
    this.operationStatus,
    this.communicationStatus,
    this.criticalAlarm,
    this.lowAlarm,
    this.mediumAlarm,
    this.highAlarm,
    this.warningAlarm,
    this.serviceDue,
    this.documentExpire,
    this.createdOn,
    this.dataTime,
    this.points,
    this.location,
    this.reason,
    this.recent,
    this.sourceId,
    this.owners,
    this.underMaintenance,
    this.thingTagPath,
    this.serialNumber,
    this.status,
    this.typeName,
    this.overtime,
  });

  String? identifier;
  String? clientDomain;
  String? clientName;
  String? domain;
  String? id;
  String? name;
  String? displayName;
  String? make;
  String? model;
  String? type;
  String? operationStatus;
  String? communicationStatus;
  bool? criticalAlarm;
  bool? lowAlarm;
  bool? mediumAlarm;
  bool? highAlarm;
  bool? warningAlarm;
  bool? serviceDue;
  bool? documentExpire;
  int? createdOn;
  int? dataTime;
  List<Point>? points;
  String? location;
  String? reason;
  bool? recent;
  String? sourceId;
  List<Owner>? owners;
  bool? underMaintenance;
  String? thingTagPath;
  String? serialNumber;
  String? status;
  String? typeName;
  bool? overtime;

  factory Latest.fromJson(Map<String, dynamic> json) => Latest(
        identifier: json["identifier"],
        clientDomain: json["clientDomain"],
        clientName: json["clientName"],
        domain: json["domain"],
        id: json["id"],
        name: json["name"],
        displayName: json["displayName"],
        make: json["make"],
        model: json["model"],
        type: json["type"],
        operationStatus: json["operationStatus"],
        communicationStatus: json["communicationStatus"],
        criticalAlarm: json["criticalAlarm"],
        lowAlarm: json["lowAlarm"],
        mediumAlarm: json["mediumAlarm"],
        highAlarm: json["highAlarm"],
        warningAlarm: json["warningAlarm"],
        serviceDue: json["serviceDue"],
        documentExpire: json["documentExpire"],
        createdOn: json["createdOn"],
        dataTime: json["dataTime"],
        points: json["points"] == null
            ? []
            : List<Point>.from(json["points"]!.map((x) => Point.fromJson(x))),
        location: json["location"],
        reason: json["reason"],
        recent: json["recent"],
        sourceId: json["sourceId"],
        owners: json["owners"] == null
            ? []
            : List<Owner>.from(json["owners"]!.map((x) => Owner.fromJson(x))),
        underMaintenance: json["underMaintenance"],
        thingTagPath: json["thingTagPath"],
        serialNumber: json["serialNumber"],
        status: json["status"],
        typeName: json["typeName"],
        overtime: json["overtime"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "clientDomain": clientDomain,
        "clientName": clientName,
        "domain": domain,
        "id": id,
        "name": name,
        "displayName": displayName,
        "make": make,
        "model": model,
        "type": type,
        "operationStatus": operationStatus,
        "communicationStatus": communicationStatus,
        "criticalAlarm": criticalAlarm,
        "lowAlarm": lowAlarm,
        "mediumAlarm": mediumAlarm,
        "highAlarm": highAlarm,
        "warningAlarm": warningAlarm,
        "serviceDue": serviceDue,
        "documentExpire": documentExpire,
        "createdOn": createdOn,
        "dataTime": dataTime,
        "points": points == null
            ? []
            : List<dynamic>.from(points!.map((x) => x.toJson())),
        "location": location,
        "reason": reason,
        "recent": recent,
        "sourceId": sourceId,
        "owners": owners == null
            ? []
            : List<dynamic>.from(owners!.map((x) => x.toJson())),
        "underMaintenance": underMaintenance,
        "thingTagPath": thingTagPath,
        "serialNumber": serialNumber,
        "status": status,
        "typeName": typeName,
        "overtime": overtime,
      };
}

class Owner {
  Owner({
    this.clientId,
    this.clientName,
  });

  String? clientId;
  String? clientName;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        clientId: json["clientId"],
        clientName: json["clientName"],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "clientName": clientName,
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
  String? dataType;
  String? displayName;
  String? type;
  Status? status;
  PointAccessType? pointAccessType;
  String? precedence;
  String? expression;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        unit: json["unit"],
        unitSymbol: json["unitSymbol"],
        data: json["data"],
        pointName: json["pointName"],
        pointId: json["pointId"],
        dataType: json["dataType"],
        displayName: json["displayName"],
        type: json["type"],
        status: statusValues.map[json["status"]],
        pointAccessType: pointAccessTypeValues.map[json["pointAccessType"]],
        precedence: json["precedence"],
        expression: json["expression"],
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "unitSymbol": unitSymbol,
        "data": data,
        "pointName": pointName,
        "pointId": pointId,
        "dataType": dataType,
        "displayName": displayName,
        "type": type,
        "status": statusValues.reverse[status],
        "pointAccessType": pointAccessTypeValues.reverse[pointAccessType],
        "precedence": precedence,
        "expression": expression,
      };
}

class DataClass {
  DataClass({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

enum PointAccessType { READONLY }

final pointAccessTypeValues =
    EnumValues({"READONLY": PointAccessType.READONLY});

enum Status { HEALTHY }

final statusValues = EnumValues({"healthy": Status.HEALTHY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
