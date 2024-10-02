class GetServiceLogsModel {
  GetServiceLog? getServiceLog;

  GetServiceLogsModel({this.getServiceLog});

  GetServiceLogsModel.fromJson(Map<String, dynamic> json) {
    getServiceLog = json['getServiceLog'] != null
        ? GetServiceLog.fromJson(json['getServiceLog'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (getServiceLog != null) {
      data['getServiceLog'] = getServiceLog!.toJson();
    }
    return data;
  }
}

class GetServiceLog {
  List<Items>? items;
  int? totalItems;
  int? totalPages;
  int? pageItemCount;
  int? currentPage;

  GetServiceLog(
      {this.items,
      this.totalItems,
      this.totalPages,
      this.pageItemCount,
      this.currentPage});

  GetServiceLog.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    pageItemCount = json['pageItemCount'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    data['pageItemCount'] = this.pageItemCount;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Items {
  String? identifier;
  String? clientDomain;
  String? clientName;
  num? actDate;
  num? createdOn;
  String? createdBy;
  double? expOdometer;
  dynamic expRunHours;
  String? cancelledReason;
  String? state;
  String? serviceName;
  String? serviceType;
  String? assetDisplayName;
  String? assetType;
  String? assetTypeName;
  String? assetParentTypeName;
  String? assetDomain;
  String? assetDomainName;
  String? assetIdentifier;
  String? checkListName;
  String? partsInfo;
  num? actOdometer;
  num? actRunHours;
  num? expDate;
  num? jobId;
  String? triggeredReason;

  Items(
      {this.identifier,
      this.clientDomain,
      this.clientName,
      this.actDate,
      this.createdOn,
      this.createdBy,
      this.expOdometer,
      this.expRunHours,
      this.cancelledReason,
      this.state,
      this.serviceName,
      this.serviceType,
      this.assetDisplayName,
      this.assetType,
      this.assetTypeName,
      this.assetParentTypeName,
      this.assetDomain,
      this.assetDomainName,
      this.assetIdentifier,
      this.checkListName,
      this.partsInfo,
      this.actOdometer,
      this.actRunHours,
      this.expDate,
      this.jobId,
      this.triggeredReason});

  Items.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    clientDomain = json['clientDomain'];
    clientName = json['clientName'];
    actDate = json['actDate'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    // expOdometer = json['expOdometer'];
    expRunHours = json['expRunHours'];
    cancelledReason = json['cancelledReason'];
    state = json['state'];
    serviceName = json['serviceName'];
    serviceType = json['serviceType'];
    assetDisplayName = json['assetDisplayName'];
    assetType = json['assetType'];
    assetTypeName = json['assetTypeName'];
    assetParentTypeName = json['assetParentTypeName'];
    assetDomain = json['assetDomain'];
    assetDomainName = json['assetDomainName'];
    assetIdentifier = json['assetIdentifier'];
    checkListName = json['checkListName'];
    partsInfo = json['partsInfo'];
    actOdometer = json['actOdometer'];
    actRunHours = json['actRunHours'];
    expDate = json['expDate'];
    jobId = json['jobId'];
    triggeredReason = json['triggeredReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['identifier'] = identifier;
    data['clientDomain'] = clientDomain;
    data['clientName'] = clientName;
    data['actDate'] = actDate;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['expOdometer'] = expOdometer;
    data['expRunHours'] = expRunHours;
    data['cancelledReason'] = cancelledReason;
    data['state'] = state;
    data['serviceName'] = serviceName;
    data['serviceType'] = serviceType;
    data['assetDisplayName'] = assetDisplayName;
    data['assetType'] = assetType;
    data['assetTypeName'] = assetTypeName;
    data['assetParentTypeName'] = assetParentTypeName;
    data['assetDomain'] = assetDomain;
    data['assetDomainName'] = assetDomainName;
    data['assetIdentifier'] = assetIdentifier;
    data['checkListName'] = checkListName;
    data['partsInfo'] = partsInfo;
    data['actOdometer'] = actOdometer;
    data['actRunHours'] = actRunHours;
    data['expDate'] = expDate;
    data['jobId'] = jobId;
    data['triggeredReason'] = triggeredReason;
    return data;
  }
}
