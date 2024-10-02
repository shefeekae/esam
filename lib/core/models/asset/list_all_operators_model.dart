// To parse this JSON data, do
//
//     final listAllOperatorsModel = listAllOperatorsModelFromJson(jsonString);

import 'dart:convert';

ListAllOperatorsModel listAllOperatorsModelFromJson(Map<String, dynamic> map) =>
    ListAllOperatorsModel.fromJson(map);

String listAllOperatorsModelToJson(ListAllOperatorsModel data) =>
    json.encode(data.toJson());

class ListAllOperatorsModel {
  ListAllOperatorsPaged? listAllOperatorsPaged;

  ListAllOperatorsModel({
    this.listAllOperatorsPaged,
  });

  factory ListAllOperatorsModel.fromJson(Map<String, dynamic> json) =>
      ListAllOperatorsModel(
        listAllOperatorsPaged: json["listAllOperatorsPaged"] == null
            ? null
            : ListAllOperatorsPaged.fromJson(json["listAllOperatorsPaged"]),
      );

  Map<String, dynamic> toJson() => {
        "listAllOperatorsPaged": listAllOperatorsPaged?.toJson(),
      };
}

class ListAllOperatorsPaged {
  List<Assignee>? items;
  int? totalItems;
  int? totalPages;
  int? pageItemCount;
  int? currentPage;

  ListAllOperatorsPaged({
    this.items,
    this.totalItems,
    this.totalPages,
    this.pageItemCount,
    this.currentPage,
  });

  factory ListAllOperatorsPaged.fromJson(Map<String, dynamic> json) =>
      ListAllOperatorsPaged(
        items: json["items"] == null
            ? []
            : List<Assignee>.from(
                json["items"]!.map((x) => Assignee.fromJson(x))),
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
