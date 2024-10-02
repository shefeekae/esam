// To parse this JSON data, do
//
//     final assetNotesModel = assetNotesModelFromJson(jsonString);

import 'dart:convert';

AssetNotesModel assetNotesModelFromJson(Map<String,dynamic> map) => AssetNotesModel.fromJson(map);

String assetNotesModelToJson(AssetNotesModel data) => json.encode(data.toJson());

class AssetNotesModel {
    AssetNotesModel({
        this.listAllNotes,
    });

    List<ListAllNote>? listAllNotes;

    factory AssetNotesModel.fromJson(Map<String, dynamic> json) => AssetNotesModel(
        listAllNotes: json["listAllNotes"] == null ? [] : List<ListAllNote>.from(json["listAllNotes"]!.map((x) => ListAllNote.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "listAllNotes": listAllNotes == null ? [] : List<dynamic>.from(listAllNotes!.map((x) => x.toJson())),
    };
}

class ListAllNote {
    ListAllNote({
        this.identifier,
        this.notes,
        this.category,
        this.asset,
        this.status,
        this.domain,
        this.systemGenerated,
        this.service,
        this.createdBy,
        this.createdOn,
    });

    String? identifier;
    String? notes;
    String? category;
    String? asset;
    String? status;
    String? domain;
    bool? systemGenerated;
    String? service;
    String? createdBy;
    int? createdOn;

    factory ListAllNote.fromJson(Map<String, dynamic> json) => ListAllNote(
        identifier: json["identifier"],
        notes: json["notes"],
        category: json["category"],
        asset: json["asset"],
        status: json["status"],
        domain: json["domain"],
        systemGenerated: json["systemGenerated"],
        service: json["service"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "notes": notes,
        "category": category,
        "asset": asset,
        "status": status,
        "domain": domain,
        "systemGenerated": systemGenerated,
        "service": service,
        "createdBy": createdBy,
        "createdOn": createdOn,
    };
}
