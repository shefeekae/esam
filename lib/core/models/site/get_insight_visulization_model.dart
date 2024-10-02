class GetSiteInsightVisualizationModel {
  GetSiteInsightVisualization? getSiteInsightVisualization;

  GetSiteInsightVisualizationModel({this.getSiteInsightVisualization});

  GetSiteInsightVisualizationModel.fromJson(Map<String, dynamic> json) {
    getSiteInsightVisualization = json['getSiteInsightVisualization'] != null
        ? GetSiteInsightVisualization.fromJson(
            json['getSiteInsightVisualization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSiteInsightVisualization != null) {
      data['getSiteInsightVisualization'] =
          getSiteInsightVisualization!.toJson();
    }
    return data;
  }
}

class GetSiteInsightVisualization {
 
  Site? site;
  Consolidation? consolidation;
 
  List<SpaceCoolingRank>? spaceCoolingRank;
  List<EquipmentMaintenanceRank>? equipmentMaintenanceRank;

  GetSiteInsightVisualization(
      {
      this.site,
      this.consolidation,
  
      this.spaceCoolingRank,
      this.equipmentMaintenanceRank,
   });

  GetSiteInsightVisualization.fromJson(Map<String, dynamic> json) {
  
    site = json['site'] != null ? Site.fromJson(json['site']) : null;
    consolidation = json['consolidation'] != null
        ? Consolidation.fromJson(json['consolidation'])
        : null;
    if (json['spaceCoolingRank'] != null) {
      spaceCoolingRank = <SpaceCoolingRank>[];
      json['spaceCoolingRank'].forEach((v) {
        spaceCoolingRank!.add(SpaceCoolingRank.fromJson(v));
      });
    }
    if (json['equipmentMaintenanceRank'] != null) {
      equipmentMaintenanceRank = <EquipmentMaintenanceRank>[];
      json['equipmentMaintenanceRank'].forEach((v) {
        equipmentMaintenanceRank!.add(EquipmentMaintenanceRank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (site != null) {
      data['site'] = site!.toJson();
    }
    if (consolidation != null) {
      data['consolidation'] = consolidation!.toJson();
    }

    if (spaceCoolingRank != null) {
      data['spaceCoolingRank'] =
          spaceCoolingRank!.map((v) => v.toJson()).toList();
    }
    if (equipmentMaintenanceRank != null) {
      data['equipmentMaintenanceRank'] =
          equipmentMaintenanceRank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Site {
  String? name;
  String? type;
  String? identifier;

  Site({this.name, this.type, this.identifier});

  Site.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['identifier'] = identifier;
    return data;
  }
}

class Consolidation {
  num? avgTemperature;
  num? avgSetpoint;
  num? avgVariance;
  num? cop;
  num? coolingIndex;

  Consolidation(
      {this.avgTemperature,
      this.avgSetpoint,
      this.avgVariance,
      this.cop,
      this.coolingIndex});

  Consolidation.fromJson(Map<String, dynamic> json) {
    avgTemperature = json['avgTemperature'];
    avgSetpoint = json['avgSetpoint'];
    avgVariance = json['avgVariance'];
    cop = json['cop'];
    coolingIndex = json['coolingIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avgTemperature'] = avgTemperature;
    data['avgSetpoint'] = avgSetpoint;
    data['avgVariance'] = avgVariance;
    data['cop'] = cop;
    data['coolingIndex'] = coolingIndex;
    return data;
  }
}

class SpaceCoolingRank {
  String? name;
  num? value;
  String? id;
  List<Path>? path;

  SpaceCoolingRank({this.name, this.value, this.id, this.path});

  SpaceCoolingRank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    id = json['id'];
    if (json['path'] != null) {
      path = <Path>[];
      json['path'].forEach((v) {
        path!.add(Path.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['id'] = id;
    if (path != null) {
      data['path'] = path!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Path {
  String? pathName;
  String? pathId;
  String? pathType;

  Path({this.pathName, this.pathId, this.pathType});

  Path.fromJson(Map<String, dynamic> json) {
    pathName = json['pathName'];
    pathId = json['pathId'];
    pathType = json['pathType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pathName'] = pathName;
    data['pathId'] = pathId;
    data['pathType'] = pathType;
    return data;
  }
}

class EquipmentMaintenanceRank {
  String? name;
  num? value;
  String? id;
  List<Path>? path;

  EquipmentMaintenanceRank({this.name, this.value, this.id, this.path});

  EquipmentMaintenanceRank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    id = json['id'];
    if (json['path'] != null) {
      path = <Path>[];
      json['path'].forEach((v) {
        path!.add(Path.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['id'] = id;
    if (path != null) {
      data['path'] = path!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
