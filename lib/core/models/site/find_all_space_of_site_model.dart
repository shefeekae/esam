

class FindAllSpacesOfSiteModel {
  List<FindAllSpacesOfSite>? findAllSpacesOfSite;

  FindAllSpacesOfSiteModel({this.findAllSpacesOfSite});

  FindAllSpacesOfSiteModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllSpacesOfSite'] != null) {
      findAllSpacesOfSite = <FindAllSpacesOfSite>[];
      json['findAllSpacesOfSite'].forEach((v) {
        findAllSpacesOfSite!.add(FindAllSpacesOfSite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findAllSpacesOfSite != null) {
      data['findAllSpacesOfSite'] =
          findAllSpacesOfSite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAllSpacesOfSite {
  String? type;
  Data? data;

  FindAllSpacesOfSite({this.type, this.data});

  FindAllSpacesOfSite.fromJson(Map<String, dynamic> json) {
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
  String? dashboardLink;
  String? identifier;
  String? level;
  String? dddLink;
  String? typeName;
  String? timeZone;
  String? description;
  String? profileImage;
  String? createdOn;
  String? ddLink;
  String? createdBy;
  String? domain;
  String? coverImage;
  String? name;
  String? order;
  String? status;

  Data(
      {this.dashboardLink,
      this.identifier,
      this.level,
      this.dddLink,
      this.typeName,
      this.timeZone,
      this.description,
      this.profileImage,
      this.createdOn,
      this.ddLink,
      this.createdBy,
      this.domain,
      this.coverImage,
      this.name,
      this.order,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    dashboardLink = json['dashboardLink'];
    identifier = json['identifier'];
    level = json['level'];
    dddLink = json['dddLink'];
    typeName = json['typeName'];
    timeZone = json['timeZone'];
    description = json['description'];
    profileImage = json['profileImage'];
    createdOn = json['createdOn'];
    ddLink = json['ddLink'];
    createdBy = json['createdBy'];
    domain = json['domain'];
    coverImage = json['coverImage'];
    name = json['name'];
    order = json['order'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dashboardLink'] = dashboardLink;
    data['identifier'] = identifier;
    data['level'] = level;
    data['dddLink'] = dddLink;
    data['typeName'] = typeName;
    data['timeZone'] = timeZone;
    data['description'] = description;
    data['profileImage'] = profileImage;
    data['createdOn'] = createdOn;
    data['ddLink'] = ddLink;
    data['createdBy'] = createdBy;
    data['domain'] = domain;
    data['coverImage'] = coverImage;
    data['name'] = name;
    data['order'] = order;
    data['status'] = status;
    return data;
  }
}
