class SchedulerModel {
  List<SchedulerItem>? getSchedulerList;

  SchedulerModel({this.getSchedulerList});

  SchedulerModel.fromJson(Map<String, dynamic> json) {
    if (json['getSchedulerList'] != null) {
      getSchedulerList = <SchedulerItem>[];
      json['getSchedulerList'].forEach((v) {
        getSchedulerList!.add(SchedulerItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSchedulerList != null) {
      data['getSchedulerList'] =
          getSchedulerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchedulerItem {
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
  String? eventId;
  String? domain;
  String? status;
  String? color;

  SchedulerItem(
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
      this.eventId,
      this.domain,
      this.color,
      this.status});

  SchedulerItem.fromJson(Map<String, dynamic> json) {
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
    eventId = json['eventId'];
    domain = json['domain'];
    status = json['status'];
    color = json['color'];
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
    data['eventId'] = eventId;
    data['domain'] = domain;
    data['status'] = status;
    data['color'] = color;
    return data;
  }
}
