// To parse this JSON data, do
//
//     final getAssetOperatorModel = getAssetOperatorModelFromJson(jsonString);

import 'dart:convert';

GetAssetOperatorModel getAssetOperatorModelFromJson(Map<String, dynamic> map) =>
    GetAssetOperatorModel.fromJson(map);

String getAssetOperatorModelToJson(GetAssetOperatorModel data) =>
    json.encode(data.toJson());

class GetAssetOperatorModel {
  List<GetAssetOperator>? getAssetOperator;

  GetAssetOperatorModel({
    this.getAssetOperator,
  });

  factory GetAssetOperatorModel.fromJson(Map<String, dynamic> json) =>
      GetAssetOperatorModel(
        getAssetOperator: json["getAssetOperator"] == null
            ? []
            : List<GetAssetOperator>.from(json["getAssetOperator"]!
                .map((x) => GetAssetOperator.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getAssetOperator": getAssetOperator == null
            ? []
            : List<dynamic>.from(getAssetOperator!.map((x) => x.toJson())),
      };
}

class GetAssetOperator {
  String? shiftName;
  String? shiftColor;
  String? textColor;
  String? resourceName;
  String? rosterIdentifier;
  int? rosterStartDate;
  int? rosterEndDate;
  String? shiftStartDate;
  String? shiftEndDate;
  Assignee? assignee;

  GetAssetOperator({
    this.shiftName,
    this.shiftColor,
    this.textColor,
    this.resourceName,
    this.rosterIdentifier,
    this.rosterStartDate,
    this.rosterEndDate,
    this.shiftStartDate,
    this.shiftEndDate,
    this.assignee,
  });

  factory GetAssetOperator.fromJson(Map<String, dynamic> json) =>
      GetAssetOperator(
        shiftName: json["shiftName"],
        shiftColor: json["shiftColor"],
        textColor: json["textColor"],
        resourceName: json["resourceName"],
        rosterIdentifier: json["rosterIdentifier"],
        rosterStartDate: json["rosterStartDate"],
        rosterEndDate: json["rosterEndDate"],
        shiftStartDate: json["shiftStartDate"],
        shiftEndDate: json["shiftEndDate"],
        assignee: json["assignee"] == null
            ? null
            : Assignee.fromJson(json["assignee"]),
      );

  Map<String, dynamic> toJson() => {
        "shiftName": shiftName,
        "shiftColor": shiftColor,
        "textColor": textColor,
        "resourceName": resourceName,
        "rosterIdentifier": rosterIdentifier,
        "rosterStartDate": rosterStartDate,
        "rosterEndDate": rosterEndDate,
        "shiftStartDate": shiftStartDate,
        "shiftEndDate": shiftEndDate,
        "assignee": assignee?.toJson(),
      };
}

class Assignee {
  int? id;
  String? name;
  Type? type;
  String? referenceId;
  String? contactNumber;
  String? emailId;
  String? domain;
  String? status;
  int? costPerHour;

  Assignee({
    this.id,
    this.name,
    this.type,
    this.referenceId,
    this.contactNumber,
    this.emailId,
    this.domain,
    this.status,
    this.costPerHour,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        id: json["id"],
        name: json["name"],
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        referenceId: json["referenceId"],
        contactNumber: json["contactNumber"],
        emailId: json["emailId"],
        domain: json["domain"],
        status: json["status"],
        costPerHour: json["costPerHour"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type?.toJson(),
        "referenceId": referenceId,
        "contactNumber": contactNumber,
        "emailId": emailId,
        "domain": domain,
        "status": status,
        "costPerHour": costPerHour,
      };
}

class Type {
  String? name;
  String? templateName;
  String? parentName;
  String? status;
  List<dynamic>? ppmFrequencies;

  Type({
    this.name,
    this.templateName,
    this.parentName,
    this.status,
    this.ppmFrequencies,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["name"],
        templateName: json["templateName"],
        parentName: json["parentName"],
        status: json["status"],
        ppmFrequencies: json["ppmFrequencies"] == null
            ? []
            : List<dynamic>.from(json["ppmFrequencies"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "templateName": templateName,
        "parentName": parentName,
        "status": status,
        "ppmFrequencies": ppmFrequencies == null
            ? []
            : List<dynamic>.from(ppmFrequencies!.map((x) => x)),
      };
}
