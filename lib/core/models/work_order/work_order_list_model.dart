

class GetWorkOrderListDataModel {
  GetWorkOrderListData? getWorkOrderListData;

  GetWorkOrderListDataModel({this.getWorkOrderListData});

  GetWorkOrderListDataModel.fromJson(Map<String, dynamic> json) {
    getWorkOrderListData = json['getWorkOrderListData'] != null
        ? GetWorkOrderListData.fromJson(json['getWorkOrderListData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getWorkOrderListData != null) {
      data['getWorkOrderListData'] = getWorkOrderListData!.toJson();
    }
    return data;
  }
}

class GetWorkOrderListData {
  List<Wolist>? wolist;

  GetWorkOrderListData({this.wolist});

  GetWorkOrderListData.fromJson(Map<String, dynamic> json) {
    if (json['wolist'] != null) {
      wolist = <Wolist>[];
      json['wolist'].forEach((v) {
        wolist!.add(Wolist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wolist != null) {
      data['wolist'] = wolist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wolist {
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
  String? completionTime;
  String? assigned;
  String? contactNo;
  String? alarmId;
  String? workordersource;

  Wolist(
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
      this.completionTime,
      this.assigned,
      this.contactNo,
      this.alarmId,
      this.workordersource});

  Wolist.fromJson(Map<String, dynamic> json) {
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
    completionTime = json['CompletionTime'];
    assigned = json['Assigned'];
    contactNo = json['ContactNo'];
    alarmId = json['AlarmId'];
    workordersource = json['Workordersource'];
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
    data['CompletionTime'] = completionTime;
    data['Assigned'] = assigned;
    data['ContactNo'] = contactNo;
    data['AlarmId'] = alarmId;
    data['Workordersource'] = workordersource;
    return data;
  }
}
