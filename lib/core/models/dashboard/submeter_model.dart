// To parse this JSON data, do
//
//     final subMeterModel = subMeterModelFromJson(jsonString);

import 'dart:convert';

SubMeterModel subMeterModelFromJson(String str) =>
    SubMeterModel.fromJson(json.decode(str));

String subMeterModelToJson(SubMeterModel data) => json.encode(data.toJson());

class SubMeterModel {
  List<GetSubMetersList>? getSubMetersList;

  SubMeterModel({
    this.getSubMetersList,
  });

  factory SubMeterModel.fromJson(Map<String, dynamic> json) => SubMeterModel(
        getSubMetersList: json["getSubMetersList"] == null
            ? []
            : List<GetSubMetersList>.from(json["getSubMetersList"]!
                .map((x) => GetSubMetersList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getSubMetersList": getSubMetersList == null
            ? []
            : List<dynamic>.from(getSubMetersList!.map((x) => x.toJson())),
      };
}

class GetSubMetersList {
  Child? child;
  List<Child>? grandchildren;

  GetSubMetersList({
    this.child,
    this.grandchildren,
  });

  factory GetSubMetersList.fromJson(Map<String, dynamic> json) =>
      GetSubMetersList(
        child: json["child"] == null ? null : Child.fromJson(json["child"]),
        grandchildren: json["grandchildren"] == null
            ? []
            : List<Child>.from(
                json["grandchildren"]!.map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "child": child?.toJson(),
        "grandchildren": grandchildren == null
            ? []
            : List<dynamic>.from(grandchildren!.map((x) => x.toJson())),
      };
}

class Child {
  String? type;
  Data? data;
  String? identifier;
  String? domain;
  String? status;

  Child({
    this.type,
    this.data,
    this.identifier,
    this.domain,
    this.status,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        type: json["type"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        identifier: json["identifier"],
        domain: json["domain"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
        "identifier": identifier,
        "domain": domain,
        "status": status,
      };
}

class Data {
  String? ownerClientId;
  String? meterNumber;
  String? displayName;
  String? typeName;
  String? sourceTagPath;
  String? profileImage;
  String? createdOn;
  String? ddLink;
  String? ownerName;
  String? feedTags;
  String? model;
  String? id;
  String? distributedOn;
  String? make;
  String? identifier;
  String? underMaintenance;
  String? dashboardLink;
  String? assetCode;
  String? contractAccountNumber;
  String? createdBy;
  String? domain;
  String? name;
  String? location;
  String? premiseNo;
  String? category;
  String? manufactureYear;
  String? status;

  Data({
    this.ownerClientId,
    this.meterNumber,
    this.displayName,
    this.typeName,
    this.sourceTagPath,
    this.profileImage,
    this.createdOn,
    this.ddLink,
    this.ownerName,
    this.feedTags,
    this.model,
    this.id,
    this.distributedOn,
    this.make,
    this.identifier,
    this.underMaintenance,
    this.dashboardLink,
    this.assetCode,
    this.contractAccountNumber,
    this.createdBy,
    this.domain,
    this.name,
    this.location,
    this.premiseNo,
    this.category,
    this.manufactureYear,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ownerClientId: json["ownerClientId"],
        meterNumber: json["meterNumber"],
        displayName: json["displayName"],
        typeName: json["typeName"],
        sourceTagPath: json["sourceTagPath"],
        profileImage: json["profileImage"],
        createdOn: json["createdOn"],
        ddLink: json["ddLink"],
        ownerName: json["ownerName"],
        feedTags: json["feedTags"],
        model: json["model"],
        id: json["id"],
        distributedOn: json["distributedOn"].toString(),
        make: json["make"],
        identifier: json["identifier"],
        underMaintenance: json["underMaintenance"],
        dashboardLink: json["dashboardLink"],
        assetCode: json["assetCode"],
        contractAccountNumber: json["contractAccountNumber"],
        createdBy: json["createdBy"],
        domain: json["domain"],
        name: json["name"],
        location: json["location"],
        premiseNo: json["premiseNo"],
        category: json["category"],
        manufactureYear: json["manufactureYear"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "ownerClientId": ownerClientId,
        "meterNumber": meterNumber,
        "displayName": displayName,
        "typeName": typeName,
        "sourceTagPath": sourceTagPath,
        "profileImage": profileImage,
        "createdOn": createdOn,
        "ddLink": ddLink,
        "ownerName": ownerName,
        "feedTags": feedTags,
        "model": model,
        "id": id,
        "distributedOn": distributedOn,
        "make": make,
        "identifier": identifier,
        "underMaintenance": underMaintenance,
        "dashboardLink": dashboardLink,
        "assetCode": assetCode,
        "contractAccountNumber": contractAccountNumber,
        "createdBy": createdBy,
        "domain": domain,
        "name": name,
        "location": location,
        "premiseNo": premiseNo,
        "category": category,
        "manufactureYear": manufactureYear,
        "status": status,
      };
}
