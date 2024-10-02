// To parse this JSON data, do
//
//     final serviceLogsDetailsModel = serviceLogsDetailsModelFromJson(jsonString);

import 'dart:convert';

ServiceLogsDetailsModel serviceLogsDetailsModelFromJson(
        Map<String, dynamic> map) =>
    ServiceLogsDetailsModel.fromJson(map);

String serviceLogsDetailsModelToJson(ServiceLogsDetailsModel data) =>
    json.encode(data.toJson());

class ServiceLogsDetailsModel {
  ServiceLogsDetailsModel({
    this.findServiceLogDetails,
  });

  FindServiceLogDetails? findServiceLogDetails;

  factory ServiceLogsDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceLogsDetailsModel(
        findServiceLogDetails: json["findServiceLogDetails"] == null
            ? null
            : FindServiceLogDetails.fromJson(json["findServiceLogDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "findServiceLogDetails": findServiceLogDetails?.toJson(),
      };
}

class FindServiceLogDetails {
  FindServiceLogDetails({
    this.serviceLog,
    this.assignee,
    this.checklist,
    this.parts,
    this.taggedService,
  });

  ServiceLog? serviceLog;
  dynamic assignee;
  List<DetailsChecklist>? checklist;
  List<Parts>? parts;
  TaggedServiceDetails? taggedService;

  factory FindServiceLogDetails.fromJson(Map<String, dynamic> json) =>
      FindServiceLogDetails(
        serviceLog: json["serviceLog"] == null
            ? null
            : ServiceLog.fromJson(json["serviceLog"]),
        assignee: json["assignee"],
        checklist: json["checklist"] == null
            ? []
            : List<DetailsChecklist>.from(
                json["checklist"]!.map((x) => DetailsChecklist.fromJson(x))),
        parts: json["parts"] == null
            ? []
            : List<Parts>.from(json["parts"]!.map((x) => Parts.fromJson(x))),
        taggedService: json['taggedService'] == null
            ? null
            : taggedServiceDetailsFromJson(
                json["taggedService"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "serviceLog": serviceLog?.toJson(),
        "assignee": assignee,
        "checklist": checklist == null
            ? []
            : List<dynamic>.from(checklist!.map((x) => x.toJson())),
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
        "taggedService": taggedService,
      };
}

class DetailsChecklist {
  DetailsChecklist({
    this.checked,
    this.serviceCheckList,
  });

  bool? checked;
  ServiceCheckList? serviceCheckList;

  factory DetailsChecklist.fromJson(Map<String, dynamic> json) =>
      DetailsChecklist(
        checked: json["checked"],
        serviceCheckList: json["serviceCheckList"] == null
            ? null
            : ServiceCheckList.fromJson(json["serviceCheckList"]),
      );

  Map<String, dynamic> toJson() => {
        "checked": checked,
        "serviceCheckList": serviceCheckList?.toJson(),
      };
}

class ServiceCheckList {
  ServiceCheckList({
    this.name,
  });

  String? name;

  factory ServiceCheckList.fromJson(Map<String, dynamic> json) =>
      ServiceCheckList(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Parts {
  Parts({
    this.quantity,
    this.fittedRunhours,
    this.fittedOdometer,
    this.partPart,
  });

  int? quantity;
  int? fittedRunhours;
  int? fittedOdometer;
  PartPart? partPart;

  factory Parts.fromJson(Map<String, dynamic> json) => Parts(
        quantity: json["quantity"],
        fittedRunhours: json["fittedRunhours"],
        fittedOdometer: json["fittedOdometer"],
        partPart: json["part"] == null ? null : PartPart.fromJson(json["part"]),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "fittedRunhours": fittedRunhours,
        "fittedOdometer": fittedOdometer,
        "part": partPart?.toJson(),
      };
}

class PartPart {
  PartPart({
    this.name,
    this.partReference,
  });

  String? name;
  String? partReference;

  factory PartPart.fromJson(Map<String, dynamic> json) => PartPart(
        name: json["name"],
        partReference: json["partReference"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "partReference": partReference,
      };
}

class ServiceLog {
  ServiceLog({
    this.identifier,
    this.actTime,
    this.actOdometer,
    this.actRunHours,
    this.expTime,
    this.expOdometer,
    this.expRunHours,
    this.remarks,
    this.state,
    this.triggeredReason,
    this.domain,
    this.name,
    this.customerSatisficationCount,
  });

  String? identifier;
  int? actTime;
  num? actOdometer;
  num? actRunHours;
  int? expTime;
  num? expOdometer;
  num? expRunHours;
  String? remarks;
  String? state;
  String? triggeredReason;
  String? domain;
  String? name;
  int? customerSatisficationCount;

  factory ServiceLog.fromJson(Map<String, dynamic> json) => ServiceLog(
      identifier: json["identifier"],
      actTime: json["actTime"],
      actOdometer: json["actOdometer"],
      actRunHours: json["actRunHours"],
      expTime: json["expTime"],
      expOdometer: json["expOdometer"]?.toDouble(),
      expRunHours: json["expRunHours"],
      remarks: json["remarks"],
      state: json["state"],
      triggeredReason: json["triggeredReason"],
      domain: json["domain"],
      name: json["name"],
      customerSatisficationCount: json['customerSatisfaction']);

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "actTime": actTime,
        "actOdometer": actOdometer,
        "actRunHours": actRunHours,
        "expTime": expTime,
        "expOdometer": expOdometer,
        "expRunHours": expRunHours,
        "remarks": remarks,
        "state": state,
        "triggeredReason": triggeredReason,
        "domain": domain,
        "name": name,
      };
}

// To parse this JSON data, do
//
//     final taggedServiceDetails = taggedServiceDetailsFromJson(jsonString);

TaggedServiceDetails taggedServiceDetailsFromJson(Map<String, dynamic> map) =>
    TaggedServiceDetails.fromJson(map);

String taggedServiceDetailsToJson(TaggedServiceDetails data) =>
    json.encode(data.toJson());

class TaggedServiceDetails {
  TaggedServiceDetails({
    this.identifier,
    this.taggedLogs,
    this.tagged,
  });

  String? identifier;
  List<TaggedLog>? taggedLogs;
  String? tagged;

  factory TaggedServiceDetails.fromJson(Map<String, dynamic> json) =>
      TaggedServiceDetails(
        identifier: json["identifier"],
        taggedLogs: json["taggedLogs"] == null
            ? []
            : List<TaggedLog>.from(
                json["taggedLogs"]!.map((x) => TaggedLog.fromJson(x))),
        tagged: json["tagged"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "taggedLogs": taggedLogs == null
            ? []
            : List<dynamic>.from(taggedLogs!.map((x) => x.toJson())),
        "tagged": tagged,
      };
}

class TaggedLog {
  TaggedLog({
    this.identifier,
    this.actTime,
    this.actOdometer,
    this.actRunHours,
    this.expTime,
    this.expRunHours,
    this.customerSatisfaction,
    this.remarks,
    this.state,
    this.triggeredReason,
    this.createdBy,
    this.createdOn,
    this.domain,
    this.name,
  });

  String? identifier;
  int? actTime;
  int? actOdometer;
  int? actRunHours;
  int? expTime;
  int? expRunHours;
  int? customerSatisfaction;
  String? remarks;
  String? state;
  String? triggeredReason;
  String? createdBy;
  int? createdOn;
  String? domain;
  String? name;

  factory TaggedLog.fromJson(Map<String, dynamic> json) => TaggedLog(
        identifier: json["identifier"],
        actTime: json["actTime"],
        actOdometer: json["actOdometer"],
        actRunHours: json["actRunHours"],
        expTime: json["expTime"],
        expRunHours: json["expRunHours"],
        customerSatisfaction: json["customerSatisfaction"],
        remarks: json["remarks"],
        state: json["state"],
        triggeredReason: json["triggeredReason"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
        domain: json["domain"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "actTime": actTime,
        "actOdometer": actOdometer,
        "actRunHours": actRunHours,
        "expTime": expTime,
        "expRunHours": expRunHours,
        "customerSatisfaction": customerSatisfaction,
        "remarks": remarks,
        "state": state,
        "triggeredReason": triggeredReason,
        "createdBy": createdBy,
        "createdOn": createdOn,
        "domain": domain,
        "name": name,
      };
}
