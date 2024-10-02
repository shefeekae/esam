// To parse this JSON data, do
//
//     final alarmsDiagnosisRoutinesModel = alarmsDiagnosisRoutinesModelFromJson(jsonString);

import 'dart:convert';

List<AlarmsDiagnosisRoutinesModel> alarmsDiagnosisRoutinesModelFromJson(
        List list) =>
    List<AlarmsDiagnosisRoutinesModel>.from(
        list.map((x) => AlarmsDiagnosisRoutinesModel.fromJson(x)));

String alarmsDiagnosisRoutinesModelToJson(
        List<AlarmsDiagnosisRoutinesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlarmsDiagnosisRoutinesModel {
  AlarmsDiagnosisRoutinesModel({
    this.diagnosticsId,
    this.eventId,
    this.sourceId,
    this.eventName,
    this.sourceType,
    this.eventTime,
    this.suggestion,
    this.report,
    this.reason,
    this.insertionTime,
  });

  String? diagnosticsId;
  String? eventId;
  String? sourceId;
  String? eventName;
  String? sourceType;
  int? eventTime;
  String? suggestion;
  AlarmsDiagnosisRoutinesModelReport? report;
  String? reason;
  int? insertionTime;

  factory AlarmsDiagnosisRoutinesModel.fromJson(Map<String, dynamic> json) =>
      AlarmsDiagnosisRoutinesModel(
        diagnosticsId: json["diagnosticsId"],
        eventId: json["eventId"],
        sourceId: json["sourceId"],
        eventName: json["eventName"],
        sourceType: json["sourceType"],
        eventTime: json["eventTime"],
        suggestion: json["suggestion"],
        report: json["report"] == null
            ? null
            : AlarmsDiagnosisRoutinesModelReport.fromJson(json["report"]),
        reason: json["reason"],
        insertionTime: json["insertionTime"],
      );

  Map<String, dynamic> toJson() => {
        "diagnosticsId": diagnosticsId,
        "eventId": eventId,
        "sourceId": sourceId,
        "eventName": eventName,
        "sourceType": sourceType,
        "eventTime": eventTime,
        "suggestion": suggestion,
        "report": report?.toJson(),
        "reason": reason,
        "insertionTime": insertionTime,
      };
}

class AlarmsDiagnosisRoutinesModelReport {
  AlarmsDiagnosisRoutinesModelReport({
    this.id,
    this.configurationName,
    this.sourceType,
    this.source,
    this.configId,
    this.status,
    this.reason,
    this.suggestion,
    this.routines,
  });

  String? id;
  String? configurationName;
  String? sourceType;
  String? source;
  String? configId;
  String? status;
  String? reason;
  String? suggestion;
  List<Routine>? routines;

  factory AlarmsDiagnosisRoutinesModelReport.fromJson(
          Map<String, dynamic> json) =>
      AlarmsDiagnosisRoutinesModelReport(
        id: json["id"],
        configurationName: json["configurationName"],
        sourceType: json["sourceType"],
        source: json["source"],
        configId: json["configId"],
        status: json["status"],
        reason: json["reason"],
        suggestion: json["suggestion"],
        routines: json["routines"] == null
            ? []
            : List<Routine>.from(
                json["routines"]!.map((x) => Routine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "configurationName": configurationName,
        "sourceType": sourceType,
        "source": source,
        "configId": configId,
        "status": status,
        "reason": reason,
        "suggestion": suggestion,
        "routines": routines == null
            ? []
            : List<dynamic>.from(routines!.map((x) => x.toJson())),
      };
}

class Routine {
  Routine({
    this.id,
    this.name,
    this.runOnConnection,
    this.condition,
    this.status,
    this.success,
    this.reports,
    this.suspects,
    this.precedence,
    this.description,
    this.executionStatus,
  });

  String? id;
  String? name;
  bool? runOnConnection;
  String? condition;
  String? status;
  bool? success;
  List<ReportElement>? reports;
  List<String>? suspects;
  int? precedence;
  String? description;
  bool? executionStatus;

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
        id: json["id"],
        name: json["name"],
        runOnConnection: json["runOnConnection"],
        condition: json["condition"],
        status: json["status"],
        success: json["success"],
        reports: json["reports"] == null
            ? []
            : List<ReportElement>.from(
                json["reports"]!.map((x) => ReportElement.fromJson(x))),
        suspects: json["suspects"] == null
            ? []
            : List<String>.from(json["suspects"]!.map((x) => x)),
        precedence: json["precedence"],
        description: json["description"],
        executionStatus: json["executionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "runOnConnection": runOnConnection,
        "condition": condition,
        "status": status,
        "success": success,
        "reports": reports == null
            ? []
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
        "suspects":
            suspects == null ? [] : List<dynamic>.from(suspects!.map((x) => x)),
        "precedence": precedence,
        "description": description,
        "executionStatus": executionStatus,
      };
}

class ReportElement {
  ReportElement({
    this.id,
    this.reason,
    this.suggestion,
    this.tools,
    this.skills,
    this.action,
    this.reportNature,
    this.actionPoint,
    this.writebackValue,
  });

  String? id;
  List<String>? reason;
  List<String>? suggestion;
  List<String>? tools;
  List<String>? skills;
  String? action;
  String? reportNature;
  String? actionPoint;
  String? writebackValue;

  factory ReportElement.fromJson(Map<String, dynamic> json) => ReportElement(
        id: json["id"],
        reason: json["reason"] == null
            ? []
            : List<String>.from(json["reason"]!.map((x) => x)),
        suggestion: json["suggestion"] == null
            ? []
            : List<String>.from(json["suggestion"]!.map((x) => x)),
        tools: json["tools"] == null
            ? []
            : List<String>.from(json["tools"]!.map((x) => x)),
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        action: json["action"],
        reportNature: json["reportNature"],
        actionPoint: json["actionPoint"],
        writebackValue: json["writebackValue"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason":
            reason == null ? [] : List<dynamic>.from(reason!.map((x) => x)),
        "suggestion": suggestion == null
            ? []
            : List<dynamic>.from(suggestion!.map((x) => x)),
        "tools": tools == null ? [] : List<dynamic>.from(tools!.map((x) => x)),
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "action": action,
        "reportNature": reportNature,
        "actionPoint": actionPoint,
        "writebackValue": writebackValue,
      };
}
