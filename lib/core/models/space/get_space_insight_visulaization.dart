// To parse this JSON data, do
//
//     final getSpaceInsightVisualizationModel = getSpaceInsightVisualizationModelFromJson(jsonString);

import 'dart:convert';

GetSpaceInsightVisualizationModel getSpaceInsightVisualizationModelFromJson(
        Map<String, dynamic> map) =>
    GetSpaceInsightVisualizationModel.fromJson(map);

String getSpaceInsightVisualizationModelToJson(
        GetSpaceInsightVisualizationModel data) =>
    json.encode(data.toJson());

class GetSpaceInsightVisualizationModel {
  GetSpaceInsightVisualization? getSpaceInsightVisualization;

  GetSpaceInsightVisualizationModel({
    this.getSpaceInsightVisualization,
  });

  factory GetSpaceInsightVisualizationModel.fromJson(
          Map<String, dynamic> json) =>
      GetSpaceInsightVisualizationModel(
        getSpaceInsightVisualization:
            json["getSpaceInsightVisualization"] == null
                ? null
                : GetSpaceInsightVisualization.fromJson(
                    json["getSpaceInsightVisualization"]),
      );

  Map<String, dynamic> toJson() => {
        "getSpaceInsightVisualization": getSpaceInsightVisualization?.toJson(),
      };
}

class GetSpaceInsightVisualization {
  dynamic equipment;
  Space? space;
  dynamic site;
  Consolidation? consolidation;
  List<Analysis>? analysis;
  dynamic durationDistribution;
  List<VarianceDistribution>? varianceDistribution;
  List<Rank>? maintenanceRank;
  List<Rank>? coolingIndexRank;
  dynamic spaceCoolingRank;
  dynamic equipmentMaintenanceRank;
  dynamic copTrend;

  GetSpaceInsightVisualization({
    this.equipment,
    this.space,
    this.site,
    this.consolidation,
    this.analysis,
    this.durationDistribution,
    this.varianceDistribution,
    this.maintenanceRank,
    this.coolingIndexRank,
    this.spaceCoolingRank,
    this.equipmentMaintenanceRank,
    this.copTrend,
  });

  factory GetSpaceInsightVisualization.fromJson(Map<String, dynamic> json) =>
      GetSpaceInsightVisualization(
        equipment: json["equipment"],
        space: json["space"] == null ? null : Space.fromJson(json["space"]),
        site: json["site"],
        consolidation: json["consolidation"] == null
            ? null
            : Consolidation.fromJson(json["consolidation"]),
        analysis: json["analysis"] == null
            ? []
            : List<Analysis>.from(
                json["analysis"]!.map((x) => Analysis.fromJson(x))),
        durationDistribution: json["durationDistribution"],
        varianceDistribution: json["varianceDistribution"] == null
            ? []
            : List<VarianceDistribution>.from(json["varianceDistribution"]!
                .map((x) => VarianceDistribution.fromJson(x))),
        maintenanceRank: json["maintenanceRank"] == null
            ? []
            : List<Rank>.from(
                json["maintenanceRank"]!.map((x) => Rank.fromJson(x))),
        coolingIndexRank: json["coolingIndexRank"] == null
            ? []
            : List<Rank>.from(
                json["coolingIndexRank"]!.map((x) => Rank.fromJson(x))),
        spaceCoolingRank: json["spaceCoolingRank"],
        equipmentMaintenanceRank: json["equipmentMaintenanceRank"],
        copTrend: json["copTrend"],
      );

  Map<String, dynamic> toJson() => {
        "equipment": equipment,
        "space": space?.toJson(),
        "site": site,
        "consolidation": consolidation?.toJson(),
        "analysis": analysis == null
            ? []
            : List<dynamic>.from(analysis!.map((x) => x.toJson())),
        "durationDistribution": durationDistribution,
        "varianceDistribution": varianceDistribution == null
            ? []
            : List<dynamic>.from(varianceDistribution!.map((x) => x.toJson())),
        "maintenanceRank": maintenanceRank == null
            ? []
            : List<dynamic>.from(maintenanceRank!.map((x) => x.toJson())),
        "coolingIndexRank": coolingIndexRank == null
            ? []
            : List<dynamic>.from(coolingIndexRank!.map((x) => x.toJson())),
        "spaceCoolingRank": spaceCoolingRank,
        "equipmentMaintenanceRank": equipmentMaintenanceRank,
        "copTrend": copTrend,
      };
}

class Analysis {
  String? type;
  num? value;

  Analysis({
    this.type,
    this.value,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) => Analysis(
        type: json["type"],
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class Consolidation {
  num? avgTemperature;
  num? avgSetpoint;
  num? avgVariance;
  num? cop;
  num? coolingIndex;

  Consolidation({
    this.avgTemperature,
    this.avgSetpoint,
    this.avgVariance,
    this.cop,
    this.coolingIndex,
  });

  factory Consolidation.fromJson(Map<String, dynamic> json) => Consolidation(
        avgTemperature: json["avgTemperature"]?.toDouble(),
        avgSetpoint: json["avgSetpoint"],
        avgVariance: json["avgVariance"]?.toDouble(),
        cop: json["cop"],
        coolingIndex: json["coolingIndex"],
      );

  Map<String, dynamic> toJson() => {
        "avgTemperature": avgTemperature,
        "avgSetpoint": avgSetpoint,
        "avgVariance": avgVariance,
        "cop": cop,
        "coolingIndex": coolingIndex,
      };
}

class Rank {
  String? name;
  num? value;
  String? id;
  dynamic path;

  Rank({
    this.name,
    this.value,
    this.id,
    this.path,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        name: json["name"],
        value: json["value"],
        id: json["id"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "id": id,
        "path": path,
      };
}

class Space {
  String? name;
  dynamic type;
  String? identifier;

  Space({
    this.name,
    this.type,
    this.identifier,
  });

  factory Space.fromJson(Map<String, dynamic> json) => Space(
        name: json["name"],
        type: json["type"],
        identifier: json["identifier"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "identifier": identifier,
      };
}

class VarianceDistribution {
  VarianceDistributionKey? key;
  int? date;
  num? value;

  VarianceDistribution({
    this.key,
    this.date,
    this.value,
  });

  factory VarianceDistribution.fromJson(Map<String, dynamic> json) =>
      VarianceDistribution(
        key: keyValues.map[json["key"]]!,
        date: json["date"],
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "key": keyValues.reverse[key],
        "date": date,
        "value": value,
      };
}

enum VarianceDistributionKey { AVG_SETPOINT, AVG_TEMPERATURE, AVG_VARIANCE }

final keyValues = EnumValues({
  "avgSetpoint": VarianceDistributionKey.AVG_SETPOINT,
  "avgTemperature": VarianceDistributionKey.AVG_TEMPERATURE,
  "avgVariance": VarianceDistributionKey.AVG_VARIANCE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
