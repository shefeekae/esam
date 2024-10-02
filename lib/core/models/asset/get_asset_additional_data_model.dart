class GetAssetAdditionalDataModel {
  List<GetAssetAdditionalData>? getAssetAdditionalData;

  GetAssetAdditionalDataModel({this.getAssetAdditionalData});

  GetAssetAdditionalDataModel.fromJson(Map<String, dynamic> json) {
    if (json['getAssetAdditionalData'] != null) {
      getAssetAdditionalData = <GetAssetAdditionalData>[];
      json['getAssetAdditionalData'].forEach((v) {
        getAssetAdditionalData!.add(GetAssetAdditionalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAssetAdditionalData != null) {
      data['getAssetAdditionalData'] =
          getAssetAdditionalData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAssetAdditionalData {
  Asset? asset;
  EventCount? eventCount;
  List<CriticalPoints>? criticalPoints;

  GetAssetAdditionalData({this.asset, this.eventCount, this.criticalPoints});

  GetAssetAdditionalData.fromJson(Map<String, dynamic> json) {
    asset = json['asset'] != null ? Asset.fromJson(json['asset']) : null;
    eventCount = json['eventCount'] != null
        ? EventCount.fromJson(json['eventCount'])
        : null;
    if (json['criticalPoints'] != null) {
      criticalPoints = <CriticalPoints>[];
      json['criticalPoints'].forEach((v) {
        criticalPoints!.add(CriticalPoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (asset != null) {
      data['asset'] = asset!.toJson();
    }
    if (eventCount != null) {
      data['eventCount'] = eventCount!.toJson();
    }
    if (criticalPoints != null) {
      data['criticalPoints'] = criticalPoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Asset {
  String? type;
  Data? data;
  String? identifier;
  String? domain;

  Asset({this.type, this.data, this.identifier, this.domain});

  Asset.fromJson(Map<String, dynamic> json) {
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
  String? pointName;
  String? dataType;

  Data({
    this.identifier,
    this.domain,
    this.dataType,
    this.pointName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    domain = json['domain'];
    pointName = json['pointName'];
    dataType = json['dataType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['domain'] = domain;
    return data;
  }
}

class EventCount {
  int? mEDIUM;
  int? lOW;
  int? critical;
  int? high;

  EventCount({this.mEDIUM, this.lOW, this.critical, this.high});

  EventCount.fromJson(Map<String, dynamic> json) {
    mEDIUM = json['MEDIUM'];
    lOW = json['LOW'];
    critical = json['CRITICAL'];
    high = json['HIGH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MEDIUM'] = mEDIUM;
    data['LOW'] = lOW;
    return data;
  }
}

class CriticalPoints {
  String? type;
  Data? data;
  String? identifier;
  String? domain;
  String? status;

  CriticalPoints({
    this.type,
    this.data,
    this.identifier,
    this.domain,
    this.status,
  });

  CriticalPoints.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    identifier = json['identifier'];
    domain = json['domain'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['identifier'] = identifier;
    data['domain'] = domain;
    data['status'] = status;
    return data;
  }
}
