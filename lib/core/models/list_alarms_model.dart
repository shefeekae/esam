import 'dart:convert';

class ListAlarmsModel {
  ListAlarms? listAlarms;

  ListAlarmsModel({this.listAlarms});

  ListAlarmsModel.fromJson(Map<String, dynamic> json) {
    listAlarms = json['listAlarms'] != null
        ? ListAlarms.fromJson(json['listAlarms'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listAlarms != null) {
      data['listAlarms'] = listAlarms!.toJson();
    }
    return data;
  }
}

class ListAlarms {
  int? count;
  List<EventLogs>? eventLogs;

  ListAlarms({this.count, this.eventLogs});

  ListAlarms.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['eventLogs'] != null) {
      eventLogs = <EventLogs>[];
      json['eventLogs'].forEach((v) {
        eventLogs!.add(EventLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (eventLogs != null) {
      data['eventLogs'] = eventLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventLogs {
  String? name;
  String? clientName;
  String? criticality;
  int? eventTime;
  bool? active;
  bool? resolved;
  bool? acknowledged;
  List? sourceTagPath;
  String? sourceTypeName;
  String? eventId;
  String? sourceId;
  String? suspectData;
  String? location;
  String? sourceName;
  String? type;
  String? group;
  String? activeMessage;
  String? sourceType;
  String? sourceDomain;
  String? workOrderId;
  String? workOrderNumber;

  EventLogs({
    this.name,
    this.clientName,
    this.criticality,
    this.eventId,
    this.eventTime,
    this.resolved,
    this.active,
    this.sourceTagPath,
    this.acknowledged,
    this.sourceTypeName,
    this.suspectData,
    this.location,
    this.sourceName,
    this.group,
    this.sourceId,
    this.type,
    this.activeMessage,
    this.sourceType,
    this.sourceDomain,
    this.workOrderId,
    this.workOrderNumber,
  });

  EventLogs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    clientName = json['clientName'];
    criticality = json['criticality'];
    eventTime = json['eventTime'];
    active = json['active'];
    eventId = json['eventId'];
    resolved = json['resolved'];
    acknowledged = json['acknowledged'];
    sourceTagPath = jsonDecode(json['sourceTagPath'] ?? "[]");
    sourceTypeName = json['sourceTypeName'];
    sourceId = json['sourceId'];
    suspectData = json['suspectData'];
    location = json['location'];
    sourceName = json['sourceName'];
    type = json['type'];
    group = json['group'];
    activeMessage = json['activeMessage'];
    sourceType = json['sourceType'];
    sourceDomain = json['sourceDomain'];
    workOrderId = json['workOrderId'];
    workOrderNumber = json['workOrderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['clientName'] = clientName;
    data['criticality'] = criticality;
    data['eventTime'] = eventTime;
    data['workOrderNo'] = workOrderNumber;
    data['workOrderId'] = workOrderId;
    return data;
  }
}
