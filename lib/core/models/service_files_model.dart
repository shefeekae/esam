// To parse this JSON data, do
//
//     final serviceDetailsFilesModel = serviceDetailsFilesModelFromJson(jsonString);

import 'dart:convert';

ServiceDetailsFilesModel serviceDetailsFilesModelFromJson(Map<String,dynamic> map) => ServiceDetailsFilesModel.fromJson(map);

String serviceDetailsFilesModelToJson(ServiceDetailsFilesModel data) => json.encode(data.toJson());

class ServiceDetailsFilesModel {
    ServiceDetailsFilesModel({
        this.getAllFilesFromSamePath,
    });

    GetAllFilesFromSamePath? getAllFilesFromSamePath;

    factory ServiceDetailsFilesModel.fromJson(Map<String, dynamic> json) => ServiceDetailsFilesModel(
        getAllFilesFromSamePath: json["getAllFilesFromSamePath"] == null ? null : GetAllFilesFromSamePath.fromJson(json["getAllFilesFromSamePath"]),
    );

    Map<String, dynamic> toJson() => {
        "getAllFilesFromSamePath": getAllFilesFromSamePath?.toJson(),
    };
}

class GetAllFilesFromSamePath {
    GetAllFilesFromSamePath({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory GetAllFilesFromSamePath.fromJson(Map<String, dynamic> json) => GetAllFilesFromSamePath(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.data,
        this.fileName,
        this.mimeType,
    });

    String? data;
    String? fileName;
    String? mimeType;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        data: json["data"],
        fileName: json["fileName"],
        mimeType: json["mimeType"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "fileName": fileName,
        "mimeType": mimeType,
    };
}
