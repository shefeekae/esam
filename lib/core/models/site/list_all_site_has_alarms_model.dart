
class ListAllSitesHasAlarmModel {
  List<ListAllSitesHasAlarm>? listAllSitesHasAlarm;

  ListAllSitesHasAlarmModel({this.listAllSitesHasAlarm});

  ListAllSitesHasAlarmModel.fromJson(Map<String, dynamic> json) {
    if (json['listAllSitesHasAlarm'] != null) {
      listAllSitesHasAlarm = <ListAllSitesHasAlarm>[];
      json['listAllSitesHasAlarm'].forEach((v) {
        listAllSitesHasAlarm!.add(ListAllSitesHasAlarm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listAllSitesHasAlarm != null) {
      data['listAllSitesHasAlarm'] =
          listAllSitesHasAlarm!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListAllSitesHasAlarm {
  String? type;
  Data? data;

  ListAllSitesHasAlarm({this.type, this.data});

  ListAllSitesHasAlarm.fromJson(Map<String, dynamic> json) {
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
  String? contactPerson;
  String? profileImage;
  String? createdOn;
  String? deltaCriticalThreshold;
  String? ownerName;
  int? distributedOn;
  String? email;
  String? area;
  String? identifier;
  String? address;
  String? timeZone;
  String? weatherSensor;
  String? system;
  String? createdBy;
  String? phone;
  String? domain;
  String? etsGraphicsLink;
  String? name;
  String? builtYear;
  String? location;
  String? deltaWarningThreshold;
  String? status;

  Data(
      {this.ownerClientId,
      this.rmsName,
      this.weatherLink,
      this.displayName,
      this.typeName,
      this.contactPerson,
      this.profileImage,
      this.createdOn,
      this.deltaCriticalThreshold,
      this.ownerName,
      this.distributedOn,
      this.email,
      this.area,
      this.identifier,
      this.address,
      this.timeZone,
      this.weatherSensor,
      this.system,
      this.createdBy,
      this.phone,
      this.domain,
      this.etsGraphicsLink,
      this.name,
      this.builtYear,
      this.location,
      this.deltaWarningThreshold,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    ownerClientId = json['ownerClientId'];
    rmsName = json['rmsName'];
    weatherLink = json['weatherLink'];
    displayName = json['displayName'];
    typeName = json['typeName'];
    contactPerson = json['contactPerson'];
    profileImage = json['profileImage'];
    createdOn = json['createdOn'];
    deltaCriticalThreshold = json['deltaCriticalThreshold'];
    ownerName = json['ownerName'];
    distributedOn = json['distributedOn'];
    email = json['email'];
    area = json['area'];
    identifier = json['identifier'];
    address = json['address'];
    timeZone = json['timeZone'];
    weatherSensor = json['weatherSensor'];
    system = json['system'];
    createdBy = json['createdBy'];
    phone = json['phone'];
    domain = json['domain'];
    etsGraphicsLink = json['etsGraphicsLink'];
    name = json['name'];
    builtYear = json['builtYear'];
    location = json['location'];
    deltaWarningThreshold = json['deltaWarningThreshold'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ownerClientId'] = ownerClientId;
    data['rmsName'] = rmsName;
    data['weatherLink'] = weatherLink;
    data['displayName'] = displayName;
    data['typeName'] = typeName;
    data['contactPerson'] = contactPerson;
    data['profileImage'] = profileImage;
    data['createdOn'] = createdOn;
    data['deltaCriticalThreshold'] = deltaCriticalThreshold;
    data['ownerName'] = ownerName;
    data['distributedOn'] = distributedOn;
    data['email'] = email;
    data['area'] = area;
    data['identifier'] = identifier;
    data['address'] = address;
    data['timeZone'] = timeZone;
    data['weatherSensor'] = weatherSensor;
    data['system'] = system;
    data['createdBy'] = createdBy;
    data['phone'] = phone;
    data['domain'] = domain;
    data['etsGraphicsLink'] = etsGraphicsLink;
    data['name'] = name;
    data['builtYear'] = builtYear;
    data['location'] = location;
    data['deltaWarningThreshold'] = deltaWarningThreshold;
    data['status'] = status;
    return data;
  }
}
