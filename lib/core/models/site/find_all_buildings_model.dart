class SitesModel {
  List<FindAllBuildings>? findAllBuildings;

  SitesModel({this.findAllBuildings});

  SitesModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllBuildings'] != null) {
      findAllBuildings = <FindAllBuildings>[];
      json['findAllBuildings'].forEach((v) {
        findAllBuildings!.add(FindAllBuildings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findAllBuildings != null) {
      data['findAllBuildings'] =
          findAllBuildings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAllBuildings {
  String? type;
  Data? data;

  FindAllBuildings({this.type, this.data});

  FindAllBuildings.fromJson(Map<String, dynamic> json) {
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
  String? rmsName;
  String? weatherLink;
  String? displayName;
  String? typeName;
  String? criticality;
  String? contactPerson;
  String? profileImage;
  String? createdOn;
  String? deltaCriticalThreshold;
  String? ownerName;
  String? email;
  String? area;
  String? identifier;
  String? address;
  String? timeZone;
  String? weatherSensor;
  String? system;
  String? createdBy;
  String? phone;
  String? etsGraphicsLink;
  String? domain;
  String? name;
  String? builtYear;
  String? location;
  String? deltaWarningThreshold;
  String? status;
  int? distributedOn;

  Data(
      {this.ownerClientId,
      this.rmsName,
      this.weatherLink,
      this.displayName,
      this.typeName,
      this.criticality,
      this.contactPerson,
      this.profileImage,
      this.createdOn,
      this.deltaCriticalThreshold,
      this.ownerName,
      this.email,
      this.area,
      this.identifier,
      this.address,
      this.timeZone,
      this.weatherSensor,
      this.system,
      this.createdBy,
      this.phone,
      this.etsGraphicsLink,
      this.domain,
      this.name,
      this.builtYear,
      this.location,
      this.deltaWarningThreshold,
      this.status,
      this.distributedOn});

  Data.fromJson(Map<String, dynamic> json) {
    ownerClientId = json['ownerClientId'];
    rmsName = json['rmsName'];
    weatherLink = json['weatherLink'];
    displayName = json['displayName'];
    typeName = json['typeName'];
    criticality = json['criticality'];
    contactPerson = json['contactPerson'];
    profileImage = json['profileImage'];
    createdOn = json['createdOn'];
    deltaCriticalThreshold = json['deltaCriticalThreshold'];
    ownerName = json['ownerName'];
    email = json['email'];
    area = json['area'];
    identifier = json['identifier'];
    address = json['address'];
    timeZone = json['timeZone'];
    weatherSensor = json['weatherSensor'];
    system = json['system'];
    createdBy = json['createdBy'];
    phone = json['phone'];
    etsGraphicsLink = json['etsGraphicsLink'];
    domain = json['domain'];
    name = json['name'];
    builtYear = json['builtYear'];
    location = json['location'];
    deltaWarningThreshold = json['deltaWarningThreshold'];
    status = json['status'];
    distributedOn = json['distributedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ownerClientId'] = ownerClientId;
    data['rmsName'] = rmsName;
    data['weatherLink'] = weatherLink;
    data['displayName'] = displayName;
    data['typeName'] = typeName;
    data['criticality'] = criticality;
    data['contactPerson'] = contactPerson;
    data['profileImage'] = profileImage;
    data['createdOn'] = createdOn;
    data['deltaCriticalThreshold'] = deltaCriticalThreshold;
    data['ownerName'] = ownerName;
    data['email'] = email;
    data['area'] = area;
    data['identifier'] = identifier;
    data['address'] = address;
    data['timeZone'] = timeZone;
    data['weatherSensor'] = weatherSensor;
    data['system'] = system;
    data['createdBy'] = createdBy;
    data['phone'] = phone;
    data['etsGraphicsLink'] = etsGraphicsLink;
    data['domain'] = domain;
    data['name'] = name;
    data['builtYear'] = builtYear;
    data['location'] = location;
    data['deltaWarningThreshold'] = deltaWarningThreshold;
    data['status'] = status;
    data['distributedOn'] = distributedOn;
    return data;
  }
}
