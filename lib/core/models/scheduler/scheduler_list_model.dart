

class SchedulerListModel {
  GetSchedulerListPaged? getSchedulerListPaged;

  SchedulerListModel({this.getSchedulerListPaged});

  SchedulerListModel.fromJson(Map<String, dynamic> json) {
    getSchedulerListPaged = json['getSchedulerListPaged'] != null
        ? GetSchedulerListPaged.fromJson(json['getSchedulerListPaged'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSchedulerListPaged != null) {
      data['getSchedulerListPaged'] = getSchedulerListPaged!.toJson();
    }
    return data;
  }
}

class GetSchedulerListPaged {
  int? totalItems;
  List<Items>? items;

  GetSchedulerListPaged({this.totalItems, this.items});

  GetSchedulerListPaged.fromJson(Map<String, dynamic> json) {
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
  String? status;

  Items(
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
      this.status});

  Items.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
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
    data['status'] = status;
    return data;
  }
}
