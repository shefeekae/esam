class SchedulerDetails {
  FindSchedule? findSchedule;

  SchedulerDetails({this.findSchedule});

  SchedulerDetails.fromJson(Map<String, dynamic> json) {
    findSchedule = json['findSchedule'] != null
        ? FindSchedule.fromJson(json['findSchedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findSchedule != null) {
      data['findSchedule'] = findSchedule!.toJson();
    }
    return data;
  }
}

class FindSchedule {
  int? id;
  String? name;
  String? description;
  int? startDay;
  int? endDay;
  String? startTime;
  String? endTime;
  bool? recurring;
  String? rrule;
  String? startCron;
  String? endCron;
  String? color;
  String? eventId;
  String? domain;
  String? filter;
  List<Source>? source;
  String? status;
  dynamic overrideDuration;

  FindSchedule(
      {this.id,
      this.name,
      this.description,
      this.startDay,
      this.endDay,
      this.startTime,
      this.endTime,
      this.recurring,
      this.rrule,
      this.startCron,
      this.endCron,
      this.color,
      this.eventId,
      this.domain,
      this.filter,
      this.source,
      this.status,
      this.overrideDuration});

  FindSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    recurring = json['recurring'];
    rrule = json['rrule'];
    startCron = json['startCron'];
    endCron = json['endCron'];
    color = json['color'];
    eventId = json['eventId'];
    domain = json['domain'];
    filter = json['filter'];
    if (json['source'] != null) {
      source = <Source>[];
      json['source'].forEach((v) {
        source!.add(Source.fromJson(v));
      });
    }
    status = json['status'];
    overrideDuration = json['overrideDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['startDay'] = startDay;
    data['endDay'] = endDay;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['recurring'] = recurring;
    data['rrule'] = rrule;
    data['startCron'] = startCron;
    data['endCron'] = endCron;
    data['color'] = color;
    data['eventId'] = eventId;
    data['domain'] = domain;
    data['filter'] = filter;
    if (source != null) {
      data['source'] = source!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['overrideDuration'] = overrideDuration;
    return data;
  }
}

class Source {
  Equipment? equipment;
  List<Points>? points;

  Source({this.equipment, this.points});

  Source.fromJson(Map<String, dynamic> json) {
    equipment = json['equipment'] != null
        ? Equipment.fromJson(json['equipment'])
        : null;
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (equipment != null) {
      data['equipment'] = equipment!.toJson();
    }
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Equipment {
  String? type;
  Data? data;

  Equipment({this.type, this.data});

  Equipment.fromJson(Map<String, dynamic> json) {
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
  String? domain;
  String? identifier;
  String? displayName;

  Data({this.domain, this.identifier, this.displayName});

  Data.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    identifier = json['identifier'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domain'] = domain;
    data['identifier'] = identifier;
    data['displayName'] = displayName;
    return data;
  }
}

class Points {
  String? pointName;
  String? operationType;
  int? priority;
  dynamic data;
  dynamic defaultData;

  Points(
      {this.pointName,
      this.operationType,
      this.priority,
      this.data,
      this.defaultData});

  Points.fromJson(Map<String, dynamic> json) {
    pointName = json['pointName'];
    operationType = json['operationType'];
    priority = json['priority'];
    data = json['data'];
    defaultData = json['defaultData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pointName'] = pointName;
    data['operationType'] = operationType;
    data['priority'] = priority;
    data['data'] = data;
    data['defaultData'] = defaultData;
    return data;
  }
}
