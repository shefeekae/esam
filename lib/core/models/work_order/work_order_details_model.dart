

class GetWorkOrderDetailsModel {
  GetWorkOrderDetails? getWorkOrderDetails;

  GetWorkOrderDetailsModel({this.getWorkOrderDetails});

  GetWorkOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    getWorkOrderDetails = json['getWorkOrderDetails'] != null
        ? GetWorkOrderDetails.fromJson(json['getWorkOrderDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getWorkOrderDetails != null) {
      data['getWorkOrderDetails'] = getWorkOrderDetails!.toJson();
    }
    return data;
  }
}

class GetWorkOrderDetails {
  List<WoDetail>? woDetail;

  GetWorkOrderDetails({this.woDetail});

  GetWorkOrderDetails.fromJson(Map<String, dynamic> json) {
    if (json['woDetail'] != null) {
      woDetail = <WoDetail>[];
      json['woDetail'].forEach((v) {
        woDetail!.add(WoDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (woDetail != null) {
      data['woDetail'] = woDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WoDetail {
  String? subContractor;
  String? wONumber;
  String? priority;
  String? wOStatus;
  String? reportedDate;
  String? targetResDate;
  String? targetCompTime;
  String? jobAgeing;
  String? responsedBy;
  String? contactNumber;
  String? contact;
  String? requestBookedBy;
  String? responseTime;
  String? workDescription;
  String? specialInstructions;
  String? completionTime;
  String? assigned;
  String? contactNo;

  WoDetail(
      {this.subContractor,
      this.wONumber,
      this.priority,
      this.wOStatus,
      this.reportedDate,
      this.targetResDate,
      this.targetCompTime,
      this.jobAgeing,
      this.responsedBy,
      this.contactNumber,
      this.contact,
      this.requestBookedBy,
      this.responseTime,
      this.workDescription,
      this.specialInstructions,
      this.completionTime,
      this.assigned,
      this.contactNo});

  WoDetail.fromJson(Map<String, dynamic> json) {
    subContractor = json['subContractor'];
    wONumber = json['WONumber'];
    priority = json['Priority'];
    wOStatus = json['WOStatus'];
    reportedDate = json['ReportedDate'];
    targetResDate = json['TargetResDate'];
    targetCompTime = json['TargetCompTime'];
    jobAgeing = json['JobAgeing'];
    responsedBy = json['ResponsedBy'];
    contactNumber = json['ContactNumber'];
    subContractor = json['SubContractor'];
    contact = json['Contact'];
    requestBookedBy = json['RequestBookedBy'];
    responseTime = json['ResponseTime'];
    workDescription = json['WorkDescription'];
    specialInstructions = json['SpecialInstructions'];
    completionTime = json['CompletionTime'];
    assigned = json['Assigned'];
    contactNo = json['ContactNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subContractor'] = subContractor;
    data['WONumber'] = wONumber;
    data['Priority'] = priority;
    data['WOStatus'] = wOStatus;
    data['ReportedDate'] = reportedDate;
    data['TargetResDate'] = targetResDate;
    data['TargetCompTime'] = targetCompTime;
    data['JobAgeing'] = jobAgeing;
    data['ResponsedBy'] = responsedBy;
    data['ContactNumber'] = contactNumber;
    data['SubContractor'] = subContractor;
    data['Contact'] = contact;
    data['RequestBookedBy'] = requestBookedBy;
    data['ResponseTime'] = responseTime;
    data['WorkDescription'] = workDescription;
    data['SpecialInstructions'] = specialInstructions;
    data['CompletionTime'] = completionTime;
    data['Assigned'] = assigned;
    data['ContactNo'] = contactNo;
    return data;
  }
}
