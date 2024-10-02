class GetPPMLogModel {
  GetPPMLog? getPPMLog;

  GetPPMLogModel({this.getPPMLog});

  GetPPMLogModel.fromJson(Map<String, dynamic> json) {
    getPPMLog = json['getPPMLog'] != null
        ? GetPPMLog.fromJson(json['getPPMLog'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getPPMLog != null) {
      data['getPPMLog'] = getPPMLog!.toJson();
    }
    return data;
  }
}

class GetPPMLog {
  int? totalItems;
  List<Items>? items;

  GetPPMLog({this.totalItems, this.items});

  GetPPMLog.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? createdBy;
  String? completedBy;
  int? duration;
  int? endTime;
  int? expectedDuration;
  int? expectedEndTime;
  String? identifier;
  dynamic notes;
  int? startTime;
  String? status;
  String? workOrderId;
  String? workOrderNo;
  dynamic jobId;
  String? id;
  dynamic createdNote;
  dynamic completedNote;

  Items(
      {this.createdBy,
      this.completedBy,
      this.duration,
      this.endTime,
      this.expectedDuration,
      this.expectedEndTime,
      this.identifier,
      this.notes,
      this.startTime,
      this.status,
      this.workOrderId,
      this.workOrderNo,
      this.jobId,
      this.id,
      this.createdNote,
      this.completedNote});

  Items.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    completedBy = json['completedBy'];
    duration = json['duration'];
    endTime = json['endTime'];
    expectedDuration = json['expectedDuration'];
    expectedEndTime = json['expectedEndTime'];
    identifier = json['identifier'];
    notes = json['notes'];
    startTime = json['startTime'];
    status = json['status'];
    workOrderId = json['workOrderId'];
    workOrderNo = json['workOrderNo'];
    jobId = json['jobId'];
    id = json['id'];
    createdNote = json['createdNote'];
    completedNote = json['completedNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdBy'] = createdBy;
    data['completedBy'] = completedBy;
    data['duration'] = duration;
    data['endTime'] = endTime;
    data['expectedDuration'] = expectedDuration;
    data['expectedEndTime'] = expectedEndTime;
    data['identifier'] = identifier;
    data['notes'] = notes;
    data['startTime'] = startTime;
    data['status'] = status;
    data['workOrderId'] = workOrderId;
    data['workOrderNo'] = workOrderNo;
    data['jobId'] = jobId;
    data['id'] = id;
    data['createdNote'] = createdNote;
    data['completedNote'] = completedNote;
    return data;
  }
}
