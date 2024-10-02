// To parse this JSON data, do
//
//     final alarmLifetimeDistributionData = alarmLifetimeDistributionDataFromJson(jsonString);

import 'dart:convert';

AlarmLifetimeDistributionData alarmLifetimeDistributionDataFromJson(
        String str) =>
    AlarmLifetimeDistributionData.fromJson(json.decode(str));

String alarmLifetimeDistributionDataToJson(
        AlarmLifetimeDistributionData data) =>
    json.encode(data.toJson());

class AlarmLifetimeDistributionData {
  GetAlarmLifeTimeDistributionData? getAlarmLifeTimeDistributionData;

  AlarmLifetimeDistributionData({
    this.getAlarmLifeTimeDistributionData,
  });

  factory AlarmLifetimeDistributionData.fromJson(Map<String, dynamic> json) =>
      AlarmLifetimeDistributionData(
        getAlarmLifeTimeDistributionData:
            json["getAlarmLifeTimeDistributionData"] == null
                ? null
                : GetAlarmLifeTimeDistributionData.fromJson(
                    json["getAlarmLifeTimeDistributionData"]),
      );

  Map<String, dynamic> toJson() => {
        "getAlarmLifeTimeDistributionData":
            getAlarmLifeTimeDistributionData?.toJson(),
      };
}

class GetAlarmLifeTimeDistributionData {
  List<Alarm>? alarms;
  List<Onboard>? onboard;

  GetAlarmLifeTimeDistributionData({
    this.alarms,
    this.onboard,
  });

  factory GetAlarmLifeTimeDistributionData.fromJson(
          Map<String, dynamic> json) =>
      GetAlarmLifeTimeDistributionData(
        alarms: json["alarms"] == null
            ? []
            : List<Alarm>.from(json["alarms"]!.map((x) => Alarm.fromJson(x))),
        onboard: json["onboard"] == null
            ? []
            : List<Onboard>.from(
                json["onboard"]!.map((x) => Onboard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "alarms": alarms == null
            ? []
            : List<dynamic>.from(alarms!.map((x) => x.toJson())),
        "onboard": onboard == null
            ? []
            : List<dynamic>.from(onboard!.map((x) => x.toJson())),
      };
}

class Alarm {
  int? date;
  int? total;
  int? active;

  Alarm({
    this.date,
    this.total,
    this.active,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
        date: json["date"],
        total: json["total"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "total": total,
        "active": active,
      };
}

class Onboard {
  Type? type;
  // Data? data;

  Onboard({
    this.type,
    // this.data,
  });

  factory Onboard.fromJson(Map<String, dynamic> json) => Onboard(
        type: typeValues.map[json["type"]]!,
        // data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        // "data": data?.toJson(),
      };
}

class Data {
  String? ownerClientId;
  String? displayName;
  TypeName? typeName;
  dynamic criticality;
  String? contactPerson;
  String? description;
  ProfileImage? profileImage;
  String? createdOn;
  String? centrepoint;
  String? ownerName;
  String? email;
  String? area;
  String? identifier;
  LocationName? locationName;
  Address? address;
  String? sakaniName;
  String? weatherSensor;
  String? system;
  CreatedBy? createdBy;
  String? phone;
  String? geoBoundary;
  Domain? domain;
  String? name;
  String? builtYear;
  String? location;
  Status? status;
  int? distributedOn;

  Data({
    this.ownerClientId,
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
    this.distributedOn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ownerClientId: json["ownerClientId"],
        displayName: json["displayName"],
        typeName: typeNameValues.map[json["typeName"]]!,
        criticality: json["criticality"],
        contactPerson: json["contactPerson"],
        description: json["description"],
        profileImage: profileImageValues.map[json["profileImage"]]!,
        createdOn: json["createdOn"],
        centrepoint: json["centrepoint"],
        ownerName: json["ownerName"],
        email: json["email"],
        area: json["area"],
        identifier: json["identifier"],
        locationName: locationNameValues.map[json["locationName"]]!,
        address: addressValues.map[json["address"]]!,
        sakaniName: json["sakaniName"],
        weatherSensor: json["weatherSensor"],
        system: json["system"],
        createdBy: createdByValues.map[json["createdBy"]]!,
        phone: json["phone"],
        geoBoundary: json["geoBoundary"],
        domain: domainValues.map[json["domain"]]!,
        name: json["name"],
        builtYear: json["builtYear"],
        location: json["location"],
        status: statusValues.map[json["status"]]!,
        distributedOn: json["distributedOn"],
      );

  Map<String, dynamic> toJson() => {
        "ownerClientId": ownerClientId,
        "displayName": displayName,
        "typeName": typeNameValues.reverse[typeName],
        "criticality": criticality,
        "contactPerson": contactPerson,
        "description": description,
        "profileImage": profileImageValues.reverse[profileImage],
        "createdOn": createdOn,
        "centrepoint": centrepoint,
        "ownerName": ownerName,
        "email": email,
        "area": area,
        "identifier": identifier,
        "locationName": locationNameValues.reverse[locationName],
        "address": addressValues.reverse[address],
        "sakaniName": sakaniName,
        "weatherSensor": weatherSensor,
        "system": system,
        "createdBy": createdByValues.reverse[createdBy],
        "phone": phone,
        "geoBoundary": geoBoundary,
        "domain": domainValues.reverse[domain],
        "name": name,
        "builtYear": builtYear,
        "location": location,
        "status": statusValues.reverse[status],
        "distributedOn": distributedOn,
      };
}

enum Address {
  BOULEVARD_CRESCENT_SHEIKH_MOHAMMED_BIN_RASHID_BLVD_DUBAI,
  DOWNTOWN_DUBAI,
  DUBAI_HILLS_ESTATE,
  EMAAR_SOUTH,
  EMPTY
}

final addressValues = EnumValues({
  "Boulevard Crescent, Sheikh Mohammed bin Rashid Blvd - Dubai":
      Address.BOULEVARD_CRESCENT_SHEIKH_MOHAMMED_BIN_RASHID_BLVD_DUBAI,
  "Downtown Dubai": Address.DOWNTOWN_DUBAI,
  "Dubai Hills Estate": Address.DUBAI_HILLS_ESTATE,
  "Emaar South": Address.EMAAR_SOUTH,
  "": Address.EMPTY
});

enum CreatedBy {
  ADMIN_DATALKZ,
  ADMIN_EMAAR,
  DUSTINE_EMAAR,
  HAMEED_EMAAR,
  RANDYSITE_EMAAR,
  SITEUSER_EMAAR,
  TECHSUPPORT_EMAAR
}

final createdByValues = EnumValues({
  "admin@datalkz": CreatedBy.ADMIN_DATALKZ,
  "admin@emaar": CreatedBy.ADMIN_EMAAR,
  "dustine@emaar": CreatedBy.DUSTINE_EMAAR,
  "hameed@emaar": CreatedBy.HAMEED_EMAAR,
  "randysite@emaar": CreatedBy.RANDYSITE_EMAAR,
  "siteuser@emaar": CreatedBy.SITEUSER_EMAAR,
  "techsupport@emaar": CreatedBy.TECHSUPPORT_EMAAR
});

enum Domain { EMAAR }

final domainValues = EnumValues({"emaar": Domain.EMAAR});

enum LocationName {
  DOWNTOWN,
  DUBAI_CREEKSIDE_18,
  DUBAI_HILLS_ESTATE_BUSINESS_PARK,
  DUBAI_HILLS_ESTATE_COLLECTIVE,
  DUBAI_HILLS_ESTATE_PARK_RIDGE,
  DUBAI_MARINA_5242,
  EMPTY
}

final locationNameValues = EnumValues({
  "Downtown": LocationName.DOWNTOWN,
  "Dubai Creekside 18": LocationName.DUBAI_CREEKSIDE_18,
  "Dubai Hills Estate Business Park":
      LocationName.DUBAI_HILLS_ESTATE_BUSINESS_PARK,
  "Dubai Hills Estate Collective": LocationName.DUBAI_HILLS_ESTATE_COLLECTIVE,
  "Dubai Hills Estate Park Ridge": LocationName.DUBAI_HILLS_ESTATE_PARK_RIDGE,
  "Dubai Marina 52 42": LocationName.DUBAI_MARINA_5242,
  "": LocationName.EMPTY
});

enum ProfileImage {
  DUBAI_HILLS_BUSINESS_PARK_104431613393187806_JPG,
  EMPTY,
  THE_29_BOULEVARD_1582274375390_JPG
}

final profileImageValues = EnumValues({
  "dubai-hills-business-park-10443-1613393187806.jpg":
      ProfileImage.DUBAI_HILLS_BUSINESS_PARK_104431613393187806_JPG,
  "": ProfileImage.EMPTY,
  "29 Boulevard-1582274375390.jpg":
      ProfileImage.THE_29_BOULEVARD_1582274375390_JPG
});

enum Status { ACTIVE, INACTIVE }

final statusValues =
    EnumValues({"ACTIVE": Status.ACTIVE, "INACTIVE": Status.INACTIVE});

enum TypeName { SUB_COMMUNITY }

final typeNameValues = EnumValues({"Sub Community": TypeName.SUB_COMMUNITY});

enum Type { SUB_COMMUNITY }

final typeValues = EnumValues({"SubCommunity": Type.SUB_COMMUNITY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
