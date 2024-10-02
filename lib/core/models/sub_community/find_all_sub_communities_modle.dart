class FindAllSubCommunitiesModel {
  List<FindAllSubCommunities>? findAllSubCommunities;

  FindAllSubCommunitiesModel({this.findAllSubCommunities});

  FindAllSubCommunitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllSubCommunities'] != null) {
      findAllSubCommunities = <FindAllSubCommunities>[];
      json['findAllSubCommunities'].forEach((v) {
        findAllSubCommunities!.add(FindAllSubCommunities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findAllSubCommunities != null) {
      data['findAllSubCommunities'] =
          findAllSubCommunities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAllSubCommunities {
  String? type;
  Data? data;

  FindAllSubCommunities({this.type, this.data});

  FindAllSubCommunities.fromJson(Map<String, dynamic> json) {
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
  String? ownerClientId;
  String? displayName;
  String? typeName;
  dynamic criticality;
  String? contactPerson;
  String? description;
  String? profileImage;
  String? createdOn;
  String? centrepoint;
  String? ownerName;
  String? email;
  String? area;
  String? identifier;
  String? locationName;
  String? address;
  String? sakaniName;
  String? weatherSensor;
  String? system;
  String? createdBy;
  String? phone;
  String? geoBoundary;
  String? domain;
  String? name;
  String? builtYear;
  String? location;
  String? status;
  int? distributedOn;

  Data(
      {this.ownerClientId,
      this.displayName,
      this.typeName,
      this.criticality,
      this.contactPerson,
      this.description,
      this.profileImage,
      this.createdOn,
      this.centrepoint,
      this.ownerName,
      this.email,
      this.area,
      this.identifier,
      this.locationName,
      this.address,
      this.sakaniName,
      this.weatherSensor,
      this.system,
      this.createdBy,
      this.phone,
      this.geoBoundary,
      this.domain,
      this.name,
      this.builtYear,
      this.location,
      this.status,
      this.distributedOn});

  Data.fromJson(Map<String, dynamic> json) {
    ownerClientId = json['ownerClientId'];
    displayName = json['displayName'];
    typeName = json['typeName'];
    criticality = json['criticality'];
    contactPerson = json['contactPerson'];
    description = json['description'];
    profileImage = json['profileImage'];
    createdOn = json['createdOn'];
    centrepoint = json['centrepoint'];
    ownerName = json['ownerName'];
    email = json['email'];
    area = json['area'];
    identifier = json['identifier'];
    locationName = json['locationName'];
    address = json['address'];
    sakaniName = json['sakaniName'];
    weatherSensor = json['weatherSensor'];
    system = json['system'];
    createdBy = json['createdBy'];
    phone = json['phone'];
    geoBoundary = json['geoBoundary'];
    domain = json['domain'];
    name = json['name'];
    builtYear = json['builtYear'];
    location = json['location'];
    status = json['status'];
    distributedOn = json['distributedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ownerClientId'] = ownerClientId;
    data['displayName'] = displayName;
    data['typeName'] = typeName;
    data['criticality'] = criticality;
    data['contactPerson'] = contactPerson;
    data['description'] = description;
    data['profileImage'] = profileImage;
    data['createdOn'] = createdOn;
    data['centrepoint'] = centrepoint;
    data['ownerName'] = ownerName;
    data['email'] = email;
    data['area'] = area;
    data['identifier'] = identifier;
    data['locationName'] = locationName;
    data['address'] = address;
    data['sakaniName'] = sakaniName;
    data['weatherSensor'] = weatherSensor;
    data['system'] = system;
    data['createdBy'] = createdBy;
    data['phone'] = phone;
    data['geoBoundary'] = geoBoundary;
    data['domain'] = domain;
    data['name'] = name;
    data['builtYear'] = builtYear;
    data['location'] = location;
    data['status'] = status;
    data['distributedOn'] = distributedOn;
    return data;
  }
}
