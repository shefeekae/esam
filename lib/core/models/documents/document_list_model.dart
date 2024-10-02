class DocumentListModel {
  GetDocumentsList? getDocumentsList;

  DocumentListModel({this.getDocumentsList});

  DocumentListModel.fromJson(Map<String, dynamic> json) {
    getDocumentsList = json['getDocumentsList'] != null
        ? GetDocumentsList.fromJson(json['getDocumentsList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getDocumentsList != null) {
      data['getDocumentsList'] = getDocumentsList!.toJson();
    }
    return data;
  }
}

class GetDocumentsList {
  List<Result>? result;
  int? totalDocumentCount;

  GetDocumentsList({this.result, this.totalDocumentCount});

  GetDocumentsList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    totalDocumentCount = json['totalDocumentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['totalDocumentCount'] = totalDocumentCount;
    return data;
  }
}

class Result {
  Document? document;
  List<DocumentCategory>? documentCategory;
  int? assetCount;

  Result({this.document, this.documentCategory, this.assetCount});

  Result.fromJson(Map<String, dynamic> json) {
    document =
        json['document'] != null ? Document.fromJson(json['document']) : null;
    if (json['documentCategory'] != null) {
      documentCategory = <DocumentCategory>[];
      json['documentCategory'].forEach((v) {
        documentCategory!.add(DocumentCategory.fromJson(v));
      });
    }
    assetCount = json['assetCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (document != null) {
      data['document'] = document!.toJson();
    }
    if (documentCategory != null) {
      data['documentCategory'] =
          documentCategory!.map((v) => v.toJson()).toList();
    }
    data['assetCount'] = assetCount;
    return data;
  }
}

class Document {
  String? type;
  Data? data;

  Document({this.type, this.data});

  Document.fromJson(Map<String, dynamic> json) {
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
  String? issuedDate;
  String? identifier;
  String? updatedBy;
  String? daysBeforeExpiry;
  String? typeName;
  String? expiryCondition;
  String? description;
  String? updatedOn;
  String? fileLocation;
  String? uploadedDate;
  String? createdOn;
  String? content;
  String? expiryDate;
  String? createdBy;
  String? historyId;
  String? domain;
  String? name;
  String? expireStatus;
  String? validity;
  String? fileType;
  String? status;
  dynamic daysBeforeExpire;

  Data(
      {this.issuedDate,
      this.identifier,
      this.updatedBy,
      this.daysBeforeExpiry,
      this.typeName,
      this.expiryCondition,
      this.description,
      this.updatedOn,
      this.fileLocation,
      this.uploadedDate,
      this.createdOn,
      this.content,
      this.expiryDate,
      this.createdBy,
      this.historyId,
      this.domain,
      this.name,
      this.expireStatus,
      this.validity,
      this.fileType,
      this.status,
      this.daysBeforeExpire});

  Data.fromJson(Map<String, dynamic> json) {
    issuedDate = json['issuedDate'];
    identifier = json['identifier'];
    updatedBy = json['updatedBy'];
    daysBeforeExpiry = json['daysBeforeExpiry'];
    typeName = json['typeName'];
    expiryCondition = json['expiryCondition'];
    description = json['description'];
    updatedOn = json['updatedOn'];
    fileLocation = json['fileLocation'];
    uploadedDate = json['uploadedDate'];
    createdOn = json['createdOn'];
    content = json['content'];
    expiryDate = json['expiryDate'];
    createdBy = json['createdBy'];
    historyId = json['historyId'];
    domain = json['domain'];
    name = json['name'];
    expireStatus = json['expireStatus'];
    validity = json['validity'];
    fileType = json['fileType'];
    status = json['status'];
    daysBeforeExpire = json['daysBeforeExpire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['issuedDate'] = issuedDate ?? "";
    data['identifier'] = identifier ?? "";
    data['updatedBy'] = updatedBy ?? "";
    data['daysBeforeExpiry'] = daysBeforeExpiry ?? "";
    data['typeName'] = typeName ?? "";
    data['expiryCondition'] = expiryCondition ?? "";
    data['description'] = description ?? "";
    data['updatedOn'] = updatedOn ?? "";
    data['fileLocation'] = fileLocation ?? "";
    data['uploadedDate'] = uploadedDate ?? "";
    data['createdOn'] = createdOn ?? "";
    data['content'] = content ?? "";
    data['expiryDate'] = expiryDate ?? "";
    data['createdBy'] = createdBy ?? "";
    data['historyId'] = historyId ?? "";
    data['domain'] = domain ?? "";
    data['name'] = name ?? "";
    data['expireStatus'] = expireStatus ?? "";
    data['validity'] = validity ?? "";
    data['fileType'] = fileType ?? "";
    data['status'] = status ?? "";
    // data['daysBeforeExpire'] = daysBeforeExpire ?? "";
    return data;
  }
}

class DocumentCategory {
  String? type;
  CategoryData? data;
  String? identifier;
  String? domain;
  String? status;

  DocumentCategory(
      {this.type, this.data, this.identifier, this.domain, this.status});

  DocumentCategory.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
    identifier = json['identifier'];
    domain = json['domain'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['identifier'] = identifier;
    data['domain'] = domain;
    data['status'] = status;
    return data;
  }
}

class CategoryData {
  String? identifier;
  String? createdBy;
  String? domain;
  String? typeName;
  String? name;
  String? description;
  String? priority;
  String? type;
  String? createdOn;
  String? status;

  CategoryData(
      {this.identifier,
      this.createdBy,
      this.domain,
      this.typeName,
      this.name,
      this.description,
      this.priority,
      this.type,
      this.createdOn,
      this.status});

  CategoryData.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    createdBy = json['createdBy'];
    domain = json['domain'];
    typeName = json['typeName'];
    name = json['name'];
    description = json['description'];
    priority = json['priority'];
    type = json['type'];
    createdOn = json['createdOn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['createdBy'] = createdBy;
    data['domain'] = domain;
    data['typeName'] = typeName;
    data['name'] = name;
    data['description'] = description;
    data['priority'] = priority;
    data['type'] = type;
    data['createdOn'] = createdOn;
    data['status'] = status;
    return data;
  }
}
