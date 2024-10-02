// To parse this JSON data, do
//
//     final documentAssetListModel = documentAssetListModelFromJson(jsonString);

import 'dart:convert';

DocumentAssetListModel documentAssetListModelFromJson(Map <String,dynamic> map) => DocumentAssetListModel.fromJson(map);

String documentAssetListModelToJson(DocumentAssetListModel data) => json.encode(data.toJson());

class DocumentAssetListModel {
    GetMappedEntitiesWithDocumentLatestData? getMappedEntitiesWithDocumentLatestData;

    DocumentAssetListModel({
        this.getMappedEntitiesWithDocumentLatestData,
    });

    factory DocumentAssetListModel.fromJson(Map<String, dynamic> json) => DocumentAssetListModel(
        getMappedEntitiesWithDocumentLatestData: json["getMappedEntitiesWithDocumentLatestData"] == null ? null : GetMappedEntitiesWithDocumentLatestData.fromJson(json["getMappedEntitiesWithDocumentLatestData"]),
    );

    Map<String, dynamic> toJson() => {
        "getMappedEntitiesWithDocumentLatestData": getMappedEntitiesWithDocumentLatestData?.toJson(),
    };
}

class GetMappedEntitiesWithDocumentLatestData {
    List<Asset>? assets;
    int? totalAssetsCount;

    GetMappedEntitiesWithDocumentLatestData({
        this.assets,
        this.totalAssetsCount,
    });

    factory GetMappedEntitiesWithDocumentLatestData.fromJson(Map<String, dynamic> json) => GetMappedEntitiesWithDocumentLatestData(
        assets: json["assets"] == null ? [] : List<Asset>.from(json["assets"]!.map((x) => Asset.fromJson(x))),
        totalAssetsCount: json["totalAssetsCount"],
    );

    Map<String, dynamic> toJson() => {
        "assets": assets == null ? [] : List<dynamic>.from(assets!.map((x) => x.toJson())),
        "totalAssetsCount": totalAssetsCount,
    };
}

class Asset {
    String? displayName;

    Asset({
        this.displayName,
    });

    factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        displayName: json["displayName"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName,
    };
}
