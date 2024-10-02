class AssetHistory {
  List<GetAssetHistory>? getAssetHistory;

  AssetHistory({this.getAssetHistory});

  AssetHistory.fromJson(Map<String, dynamic> json) {
    if (json['getAssetHistory'] != null) {
      getAssetHistory = <GetAssetHistory>[];
      json['getAssetHistory'].forEach((v) {
        getAssetHistory!.add(GetAssetHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAssetHistory != null) {
      data['getAssetHistory'] =
          getAssetHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAssetHistory {
  Source? source;
  List<PointData>? pointData;

  GetAssetHistory({this.source, this.pointData});

  GetAssetHistory.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    if (json['pointData'] != null) {
      pointData = <PointData>[];
      json['pointData'].forEach((v) {
        pointData!.add(PointData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    if (pointData != null) {
      data['pointData'] = pointData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Source {
  String? entity;
  String? type;
  // Data? data;
  String? identifier;
  String? domain;
  String? status;

  Source(
      {this.entity,
      this.type,
      // this.data,
      this.identifier,
      this.domain,
      this.status});

  Source.fromJson(Map<String, dynamic> json) {
    entity = json['entity'];
    type = json['type'];
    // data = json['data'] != null ? Data.fromJson(json['data']) : null;
    identifier = json['identifier'];
    domain = json['domain'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entity'] = entity;
    data['type'] = type;
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    data['identifier'] = identifier;
    data['domain'] = domain;
    data['status'] = status;
    return data;
  }
}

// class Data {
//   // String? identifier;
//   // String? ownerClientId;
//   // String? serialNumber;
//   // String? contractAccountNumber;
//   String? displayName;
//   // String? typeName;
//   // String? description;
//   // String? profileImage;
//   // String? createdOn;
//   // String? version;
//   // String? ddLink;
//   // String? ownerName;
//   // String? fuelType;
//   // String? createdBy;
//   // String? domain;
//   // String? name;
//   // String? model;
//   // String? premiseNo;
//   // String? id;
//   // // String? distributedOn;
//   // String? make;
//   // String? status;

//   Data(
//       {
//       //   this.identifier,
//       // this.ownerClientId,
//       // this.serialNumber,
//       // this.contractAccountNumber,
//       this.displayName,
//       // this.typeName,
//       // this.description,
//       // this.profileImage,
//       // this.createdOn,
//       // this.version,
//       // this.ddLink,
//       // this.ownerName,
//       // this.fuelType,
//       // this.createdBy,
//       // this.domain,
//       // this.name,
//       // this.model,
//       // this.premiseNo,
//       // this.id,
//       // this.distributedOn,
//       // this.make,
//       // this.status
//       });

//   Data.fromJson(Map<String, dynamic> json) {
//     // identifier = json['identifier'];
//     // ownerClientId = json['ownerClientId'];
//     // serialNumber = json['serialNumber'];
//     // contractAccountNumber = json['contractAccountNumber'];
//     displayName = json['displayName'];
//     // typeName = json['typeName'];
//     // description = json['description'];
//     // profileImage = json['profileImage'];
//     // createdOn = json['createdOn'];
//     // version = json['version'];
//     // ddLink = json['ddLink'];
//     // ownerName = json['ownerName'];
//     // fuelType = json['fuelType'];
//     // createdBy = json['createdBy'];
//     // domain = json['domain'];
//     // name = json['name'];
//     // model = json['model'];
//     // premiseNo = json['premiseNo'];
//     // id = json['id'];
//     // // distributedOn = json['distributedOn'];
//     // make = json['make'];
//     // status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // data['identifier'] = identifier;
//     // data['ownerClientId'] = ownerClientId;
//     // data['serialNumber'] = serialNumber;
//     // data['contractAccountNumber'] = contractAccountNumber;
//     // data['displayName'] = displayName;
//     // data['typeName'] = typeName;
//     // data['description'] = description;
//     // data['profileImage'] = profileImage;
//     // data['createdOn'] = createdOn;
//     // data['version'] = version;
//     // data['ddLink'] = ddLink;
//     // data['ownerName'] = ownerName;
//     // data['fuelType'] = fuelType;
//     // data['createdBy'] = createdBy;
//     // data['domain'] = domain;
//     // data['name'] = name;
//     // data['model'] = model;
//     // data['premiseNo'] = premiseNo;
//     // data['id'] = id;
//     // // data['distributedOn'] = distributedOn;
//     // data['make'] = make;
//     // data['status'] = status;
//     return data;
//   }
// }

class PointData {
  String? displayName;
  String? unit;
  String? dataType;
  List<Values>? values;

  PointData({this.displayName, this.unit, this.dataType, this.values});

  PointData.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    unit = json['unit'];
    dataType = json['dataType'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['displayName'] = displayName;
    data['unit'] = unit;
    data['dataType'] = dataType;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int? dataTime;
  int? insertTime;
  dynamic data;

  Values({this.dataTime, this.insertTime, this.data});

  Values.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    insertTime = json['insertTime'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataTime'] = dataTime;
    data['insertTime'] = insertTime;
    data['data'] = this.data;
    return data;
  }
}
