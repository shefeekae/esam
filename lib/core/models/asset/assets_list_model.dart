class AssetsListModel {
  GetAssetList? getAssetList;

  AssetsListModel({this.getAssetList});

  AssetsListModel.fromJson(Map<String, dynamic> json) {
    getAssetList = json['getAssetList'] != null
        ? GetAssetList.fromJson(json['getAssetList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAssetList != null) {
      data['getAssetList'] = getAssetList!.toJson();
    }
    return data;
  }
}

class GetAssetList {
  List<Assets>? assets;
  int? totalAssetsCount;

  GetAssetList({this.assets, this.totalAssetsCount});

  GetAssetList.fromJson(Map<String, dynamic> json) {
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
  String? state;
  Null category;
  String? clientDomain;
  String? clientName;
  String? communicationStatus;
  int? createdOn;
  bool? criticalAlarm;
  int? dataTime;
  String? displayName;
  bool? documentExpire;
  Null documentExpiryTypes;
  String? domain;
  bool? highAlarm;
  String? id;
  String? identifier;
  Null lastCommunicated;
  String? location;
  Null locationJson;
  bool? lowAlarm;
  String? make;
  bool? mediumAlarm;
  String? model;
  String? name;
  String? operationStatus;
  bool? overtime;
  List<Owners>? owners;
  Null ownersJson;
  List<Path>? path;
  List<Points>? points;
  Null pointsJson;
  String? reason;
  bool? recent;
  String? serialNumber;
  bool? serviceDue;
  String? sourceId;
  Null thingCode;
  String? thingTagPath;
  String? type;
  String? typeName;
  bool? underMaintenance;
  bool? warningAlarm;

  Assets(
      {this.state,
      this.category,
      this.clientDomain,
      this.clientName,
      this.communicationStatus,
      this.createdOn,
      this.criticalAlarm,
      this.dataTime,
      this.displayName,
      this.documentExpire,
      this.documentExpiryTypes,
      this.domain,
      this.highAlarm,
      this.id,
      this.identifier,
      this.lastCommunicated,
      this.location,
      this.locationJson,
      this.lowAlarm,
      this.make,
      this.mediumAlarm,
      this.model,
      this.name,
      this.operationStatus,
      this.overtime,
      this.owners,
      this.ownersJson,
      this.path,
      this.points,
      this.pointsJson,
      this.reason,
      this.recent,
      this.serialNumber,
      this.serviceDue,
      this.sourceId,
      this.thingCode,
      this.thingTagPath,
      this.type,
      this.typeName,
      this.underMaintenance,
      this.warningAlarm});

  Assets.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    category = json['category'];
    clientDomain = json['clientDomain'];
    clientName = json['clientName'];
    communicationStatus = json['communicationStatus'];
    createdOn = json['createdOn'];
    criticalAlarm = json['criticalAlarm'];
    dataTime = json['dataTime'];
    displayName = json['displayName'];
    documentExpire = json['documentExpire'];
    documentExpiryTypes = json['documentExpiryTypes'];
    domain = json['domain'];
    highAlarm = json['highAlarm'];
    id = json['id'];
    identifier = json['identifier'];
    lastCommunicated = json['lastCommunicated'];
    location = json['location'];
    locationJson = json['locationJson'];
    lowAlarm = json['lowAlarm'];
    make = json['make'];
    mediumAlarm = json['mediumAlarm'];
    model = json['model'];
    name = json['name'];
    operationStatus = json['operationStatus'];
    overtime = json['overtime'];
    if (json['owners'] != null) {
      owners = <Owners>[];
      json['owners'].forEach((v) {
        owners!.add(Owners.fromJson(v));
      });
    }
    ownersJson = json['ownersJson'];
    if (json['path'] != null) {
      path = <Path>[];
      json['path'].forEach((v) {
        path!.add(Path.fromJson(v));
      });
    }
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
    pointsJson = json['pointsJson'];
    reason = json['reason'];
    recent = json['recent'];
    serialNumber = json['serialNumber'];
    serviceDue = json['serviceDue'];
    sourceId = json['sourceId'];
    // thingCode = json['thingCode'];
    thingTagPath = json['thingTagPath'];
    type = json['type'];
    typeName = json['typeName'];
    underMaintenance = json['underMaintenance'];
    warningAlarm = json['warningAlarm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['category'] = category;
    data['clientDomain'] = clientDomain;
    data['clientName'] = clientName;
    data['communicationStatus'] = communicationStatus;
    data['createdOn'] = createdOn;
    data['criticalAlarm'] = criticalAlarm;
    data['dataTime'] = dataTime;
    data['displayName'] = displayName;
    data['documentExpire'] = documentExpire;
    data['documentExpiryTypes'] = documentExpiryTypes;
    data['domain'] = domain;
    data['highAlarm'] = highAlarm;
    data['id'] = id;
    data['identifier'] = identifier;
    data['lastCommunicated'] = lastCommunicated;
    data['location'] = location;
    data['locationJson'] = locationJson;
    data['lowAlarm'] = lowAlarm;
    data['make'] = make;
    data['mediumAlarm'] = mediumAlarm;
    data['model'] = model;
    data['name'] = name;
    data['operationStatus'] = operationStatus;
    data['overtime'] = overtime;
    if (owners != null) {
      data['owners'] = owners!.map((v) => v.toJson()).toList();
    }
    data['ownersJson'] = ownersJson;
    if (path != null) {
      data['path'] = path!.map((v) => v.toJson()).toList();
    }
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    data['pointsJson'] = pointsJson;
    data['reason'] = reason;
    data['recent'] = recent;
    data['serialNumber'] = serialNumber;
    data['serviceDue'] = serviceDue;
    data['sourceId'] = sourceId;
    data['thingCode'] = thingCode;
    data['thingTagPath'] = thingTagPath;
    data['type'] = type;
    data['typeName'] = typeName;
    data['underMaintenance'] = underMaintenance;
    data['warningAlarm'] = warningAlarm;
    return data;
  }
}

class Owners {
  String? clientId;
  String? clientName;

  Owners({this.clientId, this.clientName});

  Owners.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    clientName = json['clientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientId'] = clientId;
    data['clientName'] = clientName;
    return data;
  }
}

class Path {
  String? name;
  Entity? entity;

  Path({this.name, this.entity});

  Path.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    entity = json['entity'] != null ? Entity.fromJson(json['entity']) : null;
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
    data['data'] = this.data;
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
