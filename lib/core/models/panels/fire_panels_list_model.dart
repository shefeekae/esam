
class FirePanelModel {
  GetFirePanels? getFirePanels;

  FirePanelModel({this.getFirePanels});

  FirePanelModel.fromJson(Map<String, dynamic> json) {
    getFirePanels = json['getFirePanels'] != null
        ? GetFirePanels.fromJson(json['getFirePanels'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getFirePanels != null) {
      data['getFirePanels'] = getFirePanels!.toJson();
    }
    return data;
  }
}

class GetFirePanels {
  List<Assets>? assets;
  int? totalAssetsCount;

  GetFirePanels({this.assets, this.totalAssetsCount});

  GetFirePanels.fromJson(Map<String, dynamic> json) {
    if (json['assets'] != null) {
      assets = <Assets>[];
      json['assets'].forEach((v) {
        assets!.add(Assets.fromJson(v));
      });
    }
    totalAssetsCount = json['totalAssetsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (assets != null) {
      data['assets'] = assets!.map((v) => v.toJson()).toList();
    }
    data['totalAssetsCount'] = totalAssetsCount;
    return data;
  }
}

class Assets {
  String? identifier;
  String? clientDomain;
  String? clientName;
  String? domain;
  String? id;
  String? name;
  String? displayName;
  String? type;
  String? communicationStatus;
  bool? criticalAlarm;
  bool? lowAlarm;
  bool? mediumAlarm;
  bool? highAlarm;
  bool? warningAlarm;
  bool? serviceDue;
  bool? documentExpire;
  int? createdOn;
  int? dataTime;
  List<Points>? points;
  String? location;
  String? thingCode;
  String? reason;
  bool? recent;
  String? sourceId;
  bool? underMaintenance;
  String? status;
  String? typeName;
  List<Path>? path;
  EventMap? eventMap;
  bool? overtime;

  Assets(
      {this.identifier,
      this.clientDomain,
      this.clientName,
      this.domain,
      this.id,
      this.name,
      this.displayName,
      this.type,
      this.communicationStatus,
      this.criticalAlarm,
      this.lowAlarm,
      this.mediumAlarm,
      this.highAlarm,
      this.warningAlarm,
      this.serviceDue,
      this.documentExpire,
      this.createdOn,
      this.dataTime,
      this.points,
      this.location,
      this.thingCode,
      this.reason,
      this.recent,
      this.sourceId,
      this.underMaintenance,
      this.status,
      this.typeName,
      this.path,
      this.eventMap,
      this.overtime,
      });

  Assets.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    clientDomain = json['clientDomain'];
    clientName = json['clientName'];
    domain = json['domain'];
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    type = json['type'];
    communicationStatus = json['communicationStatus'];
    criticalAlarm = json['criticalAlarm'];
    lowAlarm = json['lowAlarm'];
    mediumAlarm = json['mediumAlarm'];
    highAlarm = json['highAlarm'];
    warningAlarm = json['warningAlarm'];
    serviceDue = json['serviceDue'];
    documentExpire = json['documentExpire'];
    createdOn = json['createdOn'];
    dataTime = json['dataTime'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
    location = json['location'];
    thingCode = json['thingCode'];
    reason = json['reason'];
    recent = json['recent'];
    sourceId = json['sourceId'];
    underMaintenance = json['underMaintenance'];
    status = json['status'];
    typeName = json['typeName'];
    if (json['path'] != null) {
      path = <Path>[];
      json['path'].forEach((v) {
        path!.add(Path.fromJson(v));
      });
    }
    eventMap = json['eventMap'] != null
        ? EventMap.fromJson(json['eventMap'])
        : null;
    overtime = json['overtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['identifier'] = identifier;
    data['clientDomain'] = clientDomain;
    data['clientName'] = clientName;
    data['domain'] = domain;
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['type'] = type;
    data['communicationStatus'] = communicationStatus;
    data['criticalAlarm'] = criticalAlarm;
    data['lowAlarm'] = lowAlarm;
    data['mediumAlarm'] = mediumAlarm;
    data['highAlarm'] = highAlarm;
    data['warningAlarm'] = warningAlarm;
    data['serviceDue'] = serviceDue;
    data['documentExpire'] = documentExpire;
    data['createdOn'] = createdOn;
    data['dataTime'] = dataTime;
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    data['location'] = location;
    data['thingCode'] = thingCode;
    data['reason'] = reason;
    data['recent'] = recent;
    data['sourceId'] = sourceId;
    data['underMaintenance'] = underMaintenance;
    data['status'] = status;
    data['typeName'] = typeName;
    if (path != null) {
      data['path'] = path!.map((v) => v.toJson()).toList();
    }
    if (eventMap != null) {
      data['eventMap'] = eventMap!.toJson();
    }
    data['overtime'] = overtime;
    return data;
  }
}

class Points {
  String? unit;
  String? unitSymbol;
  dynamic data;
  String? pointName;
  String? pointId;
  String? dataType;
  String? displayName;
  String? type;
  String? status;
  String? pointAccessType;
  String? precedence;
  String? expression;

  Points(
      {this.unit,
      this.unitSymbol,
      this.data,
      this.pointName,
      this.pointId,
      this.dataType,
      this.displayName,
      this.type,
      this.status,
      this.pointAccessType,
      this.precedence,
      this.expression});

  Points.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    unitSymbol = json['unitSymbol'];
    data = json['data'];
    pointName = json['pointName'];
    pointId = json['pointId'];
    dataType = json['dataType'];
    displayName = json['displayName'];
    type = json['type'];
    status = json['status'];
    pointAccessType = json['pointAccessType'];
    precedence = json['precedence'];
    expression = json['expression'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit'] = unit;
    data['unitSymbol'] = unitSymbol;
    data['data'] = data;
    data['pointName'] = pointName;
    data['pointId'] = pointId;
    data['dataType'] = dataType;
    data['displayName'] = displayName;
    data['type'] = type;
    data['status'] = status;
    data['pointAccessType'] = pointAccessType;
    data['precedence'] = precedence;
    data['expression'] = expression;
    return data;
  }
}

class Path {
  String? name;
  Entity? entity;

  Path({this.name, this.entity});

  Path.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    entity =
        json['entity'] != null ? Entity.fromJson(json['entity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (entity != null) {
      data['entity'] = entity!.toJson();
    }
    return data;
  }
}

class Entity {
  String? type;
  Data? data;
  String? identifier;
  String? domain;

  Entity({this.type, this.data, this.identifier, this.domain});

  Entity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    identifier = json['identifier'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['identifier'] = identifier;
    data['domain'] = domain;
    return data;
  }
}

class Data {
  String? identifier;
  String? domain;
  String? name;
  String? parentType;

  Data({this.identifier, this.domain, this.name, this.parentType});

  Data.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    domain = json['domain'];
    name = json['name'];
    parentType = json['parentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['domain'] = domain;
    data['name'] = name;
    data['parentType'] = parentType;
    return data;
  }
}

class EventMap {
  int? mSFDDamperActive;
  int? smokeDetectorDirty;
  int? zoneControlValveActive;
  int? headMissing;
  int? disabled;
  int? dirty;
  int? wSOActive;
  int? commonFault;
  int? rECURRINGPanelSilenced;
  int? rECURRINGPanelReset;
  int? rECURRINGFaultStatus;
  int? faultStatus;
  int? rECURRINGPullStationAlarm;
  int? rECURRINGCommonFault;

  EventMap(
      {this.mSFDDamperActive,
      this.smokeDetectorDirty,
      this.zoneControlValveActive,
      this.headMissing,
      this.disabled,
      this.dirty,
      this.wSOActive,
      this.commonFault,
      this.rECURRINGPanelSilenced,
      this.rECURRINGPanelReset,
      this.rECURRINGFaultStatus,
      this.faultStatus,
      this.rECURRINGPullStationAlarm,
      this.rECURRINGCommonFault});

  EventMap.fromJson(Map<String, dynamic> json) {
    mSFDDamperActive = json['MSFD Damper Active'];
    smokeDetectorDirty = json['Smoke Detector Dirty'];
    zoneControlValveActive = json['Zone Control Valve Active'];
    headMissing = json['Head Missing'];
    disabled = json['Disabled'];
    dirty = json['Dirty'];
    wSOActive = json['WSO Active'];
    commonFault = json['Common Fault'];
    rECURRINGPanelSilenced = json['RECURRING-Panel Silenced'];
    rECURRINGPanelReset = json['RECURRING-Panel Reset'];
    rECURRINGFaultStatus = json['RECURRING-Fault Status'];
    faultStatus = json['Fault Status'];
    rECURRINGPullStationAlarm = json['RECURRING-Pull Station Alarm'];
    rECURRINGCommonFault = json['RECURRING-Common Fault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MSFD Damper Active'] = mSFDDamperActive;
    data['Smoke Detector Dirty'] = smokeDetectorDirty;
    data['Zone Control Valve Active'] = zoneControlValveActive;
    data['Head Missing'] = headMissing;
    data['Disabled'] = disabled;
    data['Dirty'] = dirty;
    data['WSO Active'] = wSOActive;
    data['Common Fault'] = commonFault;
    data['RECURRING-Panel Silenced'] = rECURRINGPanelSilenced;
    data['RECURRING-Panel Reset'] = rECURRINGPanelReset;
    data['RECURRING-Fault Status'] = rECURRINGFaultStatus;
    data['Fault Status'] = faultStatus;
    data['RECURRING-Pull Station Alarm'] = rECURRINGPullStationAlarm;
    data['RECURRING-Common Fault'] = rECURRINGCommonFault;
    return data;
  }
}
