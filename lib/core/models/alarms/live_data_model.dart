

class AlarmLiveData {
  GetLiveData? getLiveData;

  AlarmLiveData({this.getLiveData});

  AlarmLiveData.fromJson(Map<String, dynamic> json) {
    getLiveData = json['getLiveData'] != null
        ? GetLiveData.fromJson(json['getLiveData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLiveData != null) {
      data['getLiveData'] = getLiveData!.toJson();
    }
    return data;
  }
}

class GetLiveData {
  int? dataTime;
  List<Points>? points;

  GetLiveData({this.dataTime, this.points});

  GetLiveData.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataTime'] = dataTime;
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  String? pointId;
  String? pointName;
  String? data;
  String? unit;
  // Null? accessType;
  String? dataType;
  String? pointAccessType;
  String? status;

  Points(
      {this.pointId,
      this.pointName,
      this.data,
      this.unit,
      // this.accessType,
      this.dataType,
      this.pointAccessType,
      this.status});

  Points.fromJson(Map<String, dynamic> json) {
    pointId = json['pointId'];
    pointName = json['pointName'];
    data = json['data'] == null ? "" : json['data'].toString();
    unit = json['unit'];
    // accessType = json['accessType'];
    dataType = json['dataType'];
    pointAccessType = json['pointAccessType'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pointId'] = pointId;
    data['pointName'] = pointName;
    data['data'] = this.data;
    data['unit'] = unit;
    // data['accessType'] = this.accessType;
    data['dataType'] = dataType;
    data['pointAccessType'] = pointAccessType;
    data['status'] = status;
    return data;
  }
}
