class UtilitiesSpaceDistributionDataModel {
  List<GetUtilitiesSpaceDistributionData>? getUtilitiesSpaceDistributionData;

  UtilitiesSpaceDistributionDataModel({this.getUtilitiesSpaceDistributionData});

  UtilitiesSpaceDistributionDataModel.fromJson(Map<String, dynamic> json) {
    if (json['getUtilitiesSpaceDistributionData'] != null) {
      getUtilitiesSpaceDistributionData = <GetUtilitiesSpaceDistributionData>[];
      json['getUtilitiesSpaceDistributionData'].forEach((v) {
        getUtilitiesSpaceDistributionData!
            .add(new GetUtilitiesSpaceDistributionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUtilitiesSpaceDistributionData != null) {
      data['getUtilitiesSpaceDistributionData'] =
          getUtilitiesSpaceDistributionData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUtilitiesSpaceDistributionData {
  String? label;
  num? value;
  Value? data;
  dynamic premiseNumber;

  GetUtilitiesSpaceDistributionData(
      {this.label, this.value, this.data, this.premiseNumber});

  GetUtilitiesSpaceDistributionData.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    data = json['data'] != null ? new Value.fromJson(json['data']) : null;
    premiseNumber = json['premiseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['premiseNumber'] = premiseNumber;
    return data;
  }
}

class Value {
  String? type;
  Data? data;

  Value({this.type, this.data});

  Value.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? area;
  String? identifier;
  String? clientId;
  String? offset;
  String? clientName;
  String? typeName;
  String? timeZone;
  String? profileImage;
  String? homePage;
  String? createdOn;
  String? centrepoint;
  String? weatherSensor;
  String? createdBy;
  String? domain;
  String? location;
  String? status;
  String? defaultValue;

  Data(
      {this.area,
      this.identifier,
      this.clientId,
      this.offset,
      this.clientName,
      this.typeName,
      this.timeZone,
      this.profileImage,
      this.homePage,
      this.createdOn,
      this.centrepoint,
      this.weatherSensor,
      this.createdBy,
      this.domain,
      this.location,
      this.status,
      this.defaultValue});

  Data.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    identifier = json['identifier'];
    clientId = json['clientId'];
    offset = json['offset'];
    clientName = json['clientName'];
    typeName = json['typeName'];
    timeZone = json['timeZone'];
    profileImage = json['profileImage'];
    homePage = json['homePage'];
    createdOn = json['createdOn'];
    centrepoint = json['centrepoint'];
    weatherSensor = json['weatherSensor'];
    createdBy = json['createdBy'];
    domain = json['domain'];
    location = json['location'];
    status = json['status'];
    defaultValue = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['identifier'] = identifier;
    data['clientId'] = clientId;
    data['offset'] = offset;
    data['clientName'] = clientName;
    data['typeName'] = typeName;
    data['timeZone'] = timeZone;
    data['profileImage'] = profileImage;
    data['homePage'] = homePage;
    data['createdOn'] = createdOn;
    data['centrepoint'] = centrepoint;
    data['weatherSensor'] = weatherSensor;
    data['createdBy'] = createdBy;
    data['domain'] = domain;
    data['location'] = location;
    data['status'] = status;
    data['default'] = defaultValue;
    return data;
  }
}
