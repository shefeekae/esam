// To parse this JSON data, do
//
//     final listPaginatedShiftsModel = listPaginatedShiftsModelFromJson(jsonString);

import 'dart:convert';

ListPaginatedShiftsModel listPaginatedShiftsModelFromJson(Map<String, dynamic> map) => ListPaginatedShiftsModel.fromJson(map);

String listPaginatedShiftsModelToJson(ListPaginatedShiftsModel data) => json.encode(data.toJson());

class ListPaginatedShiftsModel {
    ListPaginatedShifts? listPaginatedShifts;

    ListPaginatedShiftsModel({
        this.listPaginatedShifts,
    });

    factory ListPaginatedShiftsModel.fromJson(Map<String, dynamic> json) => ListPaginatedShiftsModel(
        listPaginatedShifts: json["listPaginatedShifts"] == null ? null : ListPaginatedShifts.fromJson(json["listPaginatedShifts"]),
    );

    Map<String, dynamic> toJson() => {
        "listPaginatedShifts": listPaginatedShifts?.toJson(),
    };
}

class ListPaginatedShifts {
    List<Shift>? items;
    int? totalItems;

    ListPaginatedShifts({
        this.items,
        this.totalItems,
    });

    factory ListPaginatedShifts.fromJson(Map<String, dynamic> json) => ListPaginatedShifts(
        items: json["items"] == null ? [] : List<Shift>.from(json["items"]!.map((x) => Shift.fromJson(x))),
        totalItems: json["totalItems"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItems": totalItems,
    };
}

class Shift {
    String? identifier;
    String? name;
    String? domain;
    String? status;
    String? createdBy;
    int? createdOn;
    String? updatedBy;
    int? updatedOn;
    String? startTime;
    String? endTime;
    int? duration;
    String? color;
    String? textColor;
    String? clientName;

    Shift({
        this.identifier,
        this.name,
        this.domain,
        this.status,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.startTime,
        this.endTime,
        this.duration,
        this.color,
        this.textColor,
        this.clientName,
    });

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        identifier: json["identifier"],
        name: json["name"],
        domain: json["domain"],
        status: json["status"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
        updatedBy: json["updatedBy"],
        updatedOn: json["updatedOn"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        duration: json["duration"],
        color: json["color"],
        textColor: json["textColor"],
        clientName: json["clientName"],
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "domain": domain,
        "status": status,
        "createdBy": createdBy,
        "createdOn": createdOn,
        "updatedBy": updatedBy,
        "updatedOn": updatedOn,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
        "color": color,
        "textColor": textColor,
        "clientName": clientName,
    };
}
