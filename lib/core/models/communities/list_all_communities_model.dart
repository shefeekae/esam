class ListAllCommunitiesModel {
  List<Community>? listAllCommunities;

  ListAllCommunitiesModel({this.listAllCommunities});

  ListAllCommunitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['listAllCommunities'] != null) {
      listAllCommunities = <Community>[];
      json['listAllCommunities'].forEach((v) {
        listAllCommunities!.add(Community.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listAllCommunities != null) {
      data['listAllCommunities'] =
          listAllCommunities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Community {
  String? type;
  Data? data;

  Community({this.type, this.data});

  Community.fromJson(Map<String, dynamic> json) {
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
  String? identifier;
  String? clientId;
  String? offset;
  String? clientName;
  String? typeName;
  String? timeZone;
  String? profileImage;
  String? createdOn;
  String? homePage;
  String? defaultValue;
  String? createdBy;
  String? domain;
  String? location;
  String? status;
  String? area;
  String? weatherSensor;
  String? ddLink;
  String? locationName;

  Data(
      {this.identifier,
      this.clientId,
      this.offset,
      this.clientName,
      this.typeName,
      this.timeZone,
      this.profileImage,
      this.createdOn,
      this.homePage,
      this.defaultValue,
      this.createdBy,
      this.domain,
      this.location,
      this.status,
      this.area,
      this.weatherSensor,
      this.ddLink,
      this.locationName});

  Data.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    clientId = json['clientId'];
    offset = json['offset'];
    clientName = json['clientName'];
    typeName = json['typeName'];
    timeZone = json['timeZone'];
    profileImage = json['profileImage'];
    createdOn = json['createdOn'];
    homePage = json['homePage'];
    defaultValue = json['default'];
    createdBy = json['createdBy'];
    domain = json['domain'];
    location = json['location'];
    status = json['status'];
    area = json['area'];
    weatherSensor = json['weatherSensor'];
    ddLink = json['ddLink'];
    locationName = json['locationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['clientId'] = clientId;
    data['offset'] = offset;
    data['clientName'] = clientName;
    data['typeName'] = typeName;
    data['timeZone'] = timeZone;
    data['profileImage'] = profileImage;
    data['createdOn'] = createdOn;
    data['homePage'] = homePage;
    data['default'] = defaultValue;
    data['createdBy'] = createdBy;
    data['domain'] = domain;
    data['location'] = location;
    data['status'] = status;
    data['area'] = area;
    data['weatherSensor'] = weatherSensor;
    data['ddLink'] = ddLink;
    data['locationName'] = locationName;
    return data;
  }
}
