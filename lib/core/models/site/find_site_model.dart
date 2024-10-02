import 'dart:convert';

class FindSiteModel {
    final FindSite? findSite;

    FindSiteModel({
        this.findSite,
    });

    factory FindSiteModel.fromRawJson(String str) => FindSiteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FindSiteModel.fromJson(Map<String, dynamic> json) => FindSiteModel(
        findSite: json["findSite"] == null ? null : FindSite.fromJson(json["findSite"]),
    );

    Map<String, dynamic> toJson() => {
        "findSite": findSite?.toJson(),
    };
}

class FindSite {
    final Site? site;
    final Site? siteGroup;
    final List<Contact>? bmsContact;
    final List<Contact>? fmsContact;
    final List<Contact>? associationManagerContact;
    final List<Contact>? securityContact;

    FindSite({
        this.site,
        this.siteGroup,
        this.bmsContact,
        this.fmsContact,
        this.associationManagerContact,
        this.securityContact,
    });

    factory FindSite.fromRawJson(String str) => FindSite.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FindSite.fromJson(Map<String, dynamic> json) => FindSite(
        site: json["site"] == null ? null : Site.fromJson(json["site"]),
        siteGroup: json["siteGroup"] == null ? null : Site.fromJson(json["siteGroup"]),
        bmsContact: json["bmsContact"] == null ? [] : List<Contact>.from(json["bmsContact"]!.map((x) => Contact.fromJson(x))),
        fmsContact: json["fmsContact"] == null ? [] : List<Contact>.from(json["fmsContact"]!.map((x) => Contact.fromJson(x))),
        associationManagerContact: json["associationManagerContact"] == null ? [] : List<Contact>.from(json["associationManagerContact"]!.map((x) => Contact.fromJson(x))),
        securityContact: json["securityContact"] == null ? [] : List<Contact>.from(json["securityContact"]!.map((x) => Contact.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site": site?.toJson(),
        "siteGroup": siteGroup?.toJson(),
        "bmsContact": bmsContact == null ? [] : List<dynamic>.from(bmsContact!.map((x) => x.toJson())),
        "fmsContact": fmsContact == null ? [] : List<dynamic>.from(fmsContact!.map((x) => x.toJson())),
        "associationManagerContact": associationManagerContact == null ? [] : List<dynamic>.from(associationManagerContact!.map((x) => x.toJson())),
        "securityContact": securityContact == null ? [] : List<dynamic>.from(securityContact!.map((x) => x.toJson())),
    };
}

class Contact {
    final String? identifier;
    final String? name;
    final String? domain;
    final List<Phone>? phones;
    final List<Email>? emails;
    final List<Address>? addresses;
    final String? status;

    Contact({
        this.identifier,
        this.name,
        this.domain,
        this.phones,
        this.emails,
        this.addresses,
        this.status,
    });

    factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        identifier: json["identifier"],
        name: json["name"],
        domain: json["domain"],
        phones: json["phones"] == null ? [] : List<Phone>.from(json["phones"]!.map((x) => Phone.fromJson(x))),
        emails: json["emails"] == null ? [] : List<Email>.from(json["emails"]!.map((x) => Email.fromJson(x))),
        addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "domain": domain,
        "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x.toJson())),
        "emails": emails == null ? [] : List<dynamic>.from(emails!.map((x) => x.toJson())),
        "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "status": status,
    };
}

class Address {
    final String? address;
    final String? street;
    final String? poBox;
    final String? area;
    final String? state;
    final String? country;
    final String? type;

    Address({
        this.address,
        this.street,
        this.poBox,
        this.area,
        this.state,
        this.country,
        this.type,
    });

    factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        street: json["street"],
        poBox: json["poBox"],
        area: json["area"],
        state: json["state"],
        country: json["country"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "street": street,
        "poBox": poBox,
        "area": area,
        "state": state,
        "country": country,
        "type": type,
    };
}

class Email {
    final String? type;
    final String? emailId;

    Email({
        this.type,
        this.emailId,
    });

    factory Email.fromRawJson(String str) => Email.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Email.fromJson(Map<String, dynamic> json) => Email(
        type: json["type"],
        emailId: json["emailId"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "emailId": emailId,
    };
}

class Phone {
    final String? type;
    final String? number;

    Phone({
        this.type,
        this.number,
    });

    factory Phone.fromRawJson(String str) => Phone.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        type: json["type"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "number": number,
    };
}

class Site {
    final String? type;
    final Data? data;

    Site({
        this.type,
        this.data,
    });

    factory Site.fromRawJson(String str) => Site.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Site.fromJson(Map<String, dynamic> json) => Site(
        type: json["type"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "data": data?.toJson(),
    };
}

class Data {
    final String? ownerClientId;
    final String? rmsName;
    final String? weatherLink;
    final String? displayName;
    final String? typeName;
    final String? criticality;
    final String? contactPerson;
    final String? profileImage;
    final String? createdOn;
    final String? deltaCriticalThreshold;
    final String? ownerName;
    final int? distributedOn;
    final String? email;
    final String? area;
    final String? identifier;
    final String? address;
    final String? timeZone;
    final String? weatherSensor;
    final String? system;
    final String? createdBy;
    final String? phone;
    final String? etsGraphicsLink;
    final String? domain;
    final String? name;
    final String? builtYear;
    final String? location;
    final String? deltaWarningThreshold;
    final String? status;
    final String? description;
    final String? centrepoint;
    final String? locationName;
    final String? sakaniName;
    final String? geoBoundary;

    Data({
        this.ownerClientId,
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
        this.etsGraphicsLink,
        this.domain,
        this.name,
        this.builtYear,
        this.location,
        this.deltaWarningThreshold,
        this.status,
        this.description,
        this.centrepoint,
        this.locationName,
        this.sakaniName,
        this.geoBoundary,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        ownerClientId: json["ownerClientId"],
        rmsName: json["rmsName"],
        weatherLink: json["weatherLink"],
        displayName: json["displayName"],
        typeName: json["typeName"],
        criticality: json["criticality"],
        contactPerson: json["contactPerson"],
        profileImage: json["profileImage"],
        createdOn: json["createdOn"],
        deltaCriticalThreshold: json["deltaCriticalThreshold"],
        ownerName: json["ownerName"],
        distributedOn: json["distributedOn"],
        email: json["email"],
        area: json["area"],
        identifier: json["identifier"],
        address: json["address"],
        timeZone: json["timeZone"],
        weatherSensor: json["weatherSensor"],
        system: json["system"],
        createdBy: json["createdBy"],
        phone: json["phone"],
        etsGraphicsLink: json["etsGraphicsLink"],
        domain: json["domain"],
        name: json["name"],
        builtYear: json["builtYear"],
        location: json["location"],
        deltaWarningThreshold: json["deltaWarningThreshold"],
        status: json["status"],
        description: json["description"],
        centrepoint: json["centrepoint"],
        locationName: json["locationName"],
        sakaniName: json["sakaniName"],
        geoBoundary: json["geoBoundary"],
    );

    Map<String, dynamic> toJson() => {
        "ownerClientId": ownerClientId,
        "rmsName": rmsName,
        "weatherLink": weatherLink,
        "displayName": displayName,
        "typeName": typeName,
        "criticality": criticality,
        "contactPerson": contactPerson,
        "profileImage": profileImage,
        "createdOn": createdOn,
        "deltaCriticalThreshold": deltaCriticalThreshold,
        "ownerName": ownerName,
        "distributedOn": distributedOn,
        "email": email,
        "area": area,
        "identifier": identifier,
        "address": address,
        "timeZone": timeZone,
        "weatherSensor": weatherSensor,
        "system": system,
        "createdBy": createdBy,
        "phone": phone,
        "etsGraphicsLink": etsGraphicsLink,
        "domain": domain,
        "name": name,
        "builtYear": builtYear,
        "location": location,
        "deltaWarningThreshold": deltaWarningThreshold,
        "status": status,
        "description": description,
        "centrepoint": centrepoint,
        "locationName": locationName,
        "sakaniName": sakaniName,
        "geoBoundary": geoBoundary,
    };
}
