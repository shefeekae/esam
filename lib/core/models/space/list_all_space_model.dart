class SpaceModel {
  List<ListAllSpacesPagination>? listAllSpacesPagination;

  SpaceModel({this.listAllSpacesPagination});

  SpaceModel.fromJson(Map<String, dynamic> json) {
    if (json['listAllSpacesPagination'] != null) {
      listAllSpacesPagination = <ListAllSpacesPagination>[];
      json['listAllSpacesPagination'].forEach((v) {
        listAllSpacesPagination!.add(ListAllSpacesPagination.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listAllSpacesPagination != null) {
      data['listAllSpacesPagination'] =
          listAllSpacesPagination!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListAllSpacesPagination {
  Space? space;
  String? site;
  String? subCommunity;

  ListAllSpacesPagination({this.space, this.site, this.subCommunity});

  ListAllSpacesPagination.fromJson(Map<String, dynamic> json) {
    space = json['space'] != null ? Space.fromJson(json['space']) : null;
    site = json['site'];
    subCommunity = json['subCommunity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (space != null) {
      data['space'] = space!.toJson();
    }
    data['site'] = site;
    data['subCommunity'] = subCommunity;
    return data;
  }
}

class Space {
  String? type;
  Data? data;

  Space({this.type, this.data});

  Space.fromJson(Map<String, dynamic> json) {
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
  String? dddLink;
  String? typeName;
  String? description;
  String? profileImage;
  String? createdOn;
  String? ddLink;
  String? createdBy;
  String? coverImage;
  String? domain;
  String? name;
  String? order;
  String? status;
  String? timeZone;
  String? level;

  Data(
      {this.dashboardLink,
      this.identifier,
      this.dddLink,
      this.typeName,
      this.description,
      this.profileImage,
      this.createdOn,
      this.ddLink,
      this.createdBy,
      this.coverImage,
      this.domain,
      this.name,
      this.order,
      this.status,
      this.timeZone,
      this.level});

  Data.fromJson(Map<String, dynamic> json) {
    dashboardLink = json['dashboardLink'];
    identifier = json['identifier'];
    dddLink = json['dddLink'];
    typeName = json['typeName'];
    description = json['description'];
    profileImage = json['profileImage'];
    createdOn = json['createdOn'];
    ddLink = json['ddLink'];
    createdBy = json['createdBy'];
    coverImage = json['coverImage'];
    domain = json['domain'];
    name = json['name'];
    order = json['order'];
    status = json['status'];
    timeZone = json['timeZone'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dashboardLink'] = dashboardLink;
    data['identifier'] = identifier;
    data['dddLink'] = dddLink;
    data['typeName'] = typeName;
    data['description'] = description;
    data['profileImage'] = profileImage;
    data['createdOn'] = createdOn;
    data['ddLink'] = ddLink;
    data['createdBy'] = createdBy;
    data['coverImage'] = coverImage;
    data['domain'] = domain;
    data['name'] = name;
    data['order'] = order;
    data['status'] = status;
    data['timeZone'] = timeZone;
    data['level'] = level;
    return data;
  }
}
