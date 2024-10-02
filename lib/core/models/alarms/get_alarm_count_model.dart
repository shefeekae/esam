

class GetAlarmCountModel {
  GetAlarmCount? getAlarmCount;

  GetAlarmCountModel({this.getAlarmCount});

  GetAlarmCountModel.fromJson(Map<String, dynamic> json) {
    getAlarmCount = json['getAlarmCount'] != null
        ? GetAlarmCount.fromJson(json['getAlarmCount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAlarmCount != null) {
      data['getAlarmCount'] = getAlarmCount!.toJson();
    }
    return data;
  }
}

class GetAlarmCount {
  int? totalUnacknowledged;
  int? shutdown;
  int? shutdownUnacknowledged;
  int? critical;
  int? criticalUnacknowledged;
  int? medium;
  int? mediumUnacknowledged;
  int? low;
  int? lowUnacknowledged;
  int? high;
  int? highUnacknowledged;
  int? warning;
  int? warningUnacknowledged;
  int? actioned;
  int? resolved;
  int? resolvedUnacknowledged;
  int? preventiveUnacknowledged;
  int? predictiveUnacknowledged;
  int? total;

  GetAlarmCount(
      {this.totalUnacknowledged,
      this.shutdown,
      this.shutdownUnacknowledged,
      this.critical,
      this.criticalUnacknowledged,
      this.medium,
      this.mediumUnacknowledged,
      this.low,
      this.lowUnacknowledged,
      this.high,
      this.highUnacknowledged,
      this.warning,
      this.warningUnacknowledged,
      this.actioned,
      this.resolved,
      this.resolvedUnacknowledged,
      this.preventiveUnacknowledged,
      this.predictiveUnacknowledged,
      this.total});

  GetAlarmCount.fromJson(Map<String, dynamic> json) {
    totalUnacknowledged = json['totalUnacknowledged'];
    shutdown = json['shutdown'];
    shutdownUnacknowledged = json['shutdownUnacknowledged'];
    critical = json['critical'];
    criticalUnacknowledged = json['criticalUnacknowledged'];
    medium = json['medium'];
    mediumUnacknowledged = json['mediumUnacknowledged'];
    low = json['low'];
    lowUnacknowledged = json['lowUnacknowledged'];
    high = json['high'];
    highUnacknowledged = json['highUnacknowledged'];
    warning = json['warning'];
    warningUnacknowledged = json['warningUnacknowledged'];
    actioned = json['actioned'];
    resolved = json['resolved'];
    resolvedUnacknowledged = json['resolvedUnacknowledged'];
    preventiveUnacknowledged = json['preventiveUnacknowledged'];
    predictiveUnacknowledged = json['predictiveUnacknowledged'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalUnacknowledged'] = totalUnacknowledged;
    data['shutdown'] = shutdown;
    data['shutdownUnacknowledged'] = shutdownUnacknowledged;
    data['critical'] = critical;
    data['criticalUnacknowledged'] = criticalUnacknowledged;
    data['medium'] = medium;
    data['mediumUnacknowledged'] = mediumUnacknowledged;
    data['low'] = low;
    data['lowUnacknowledged'] = lowUnacknowledged;
    data['high'] = high;
    data['highUnacknowledged'] = highUnacknowledged;
    data['warning'] = warning;
    data['warningUnacknowledged'] = warningUnacknowledged;
    data['actioned'] = actioned;
    data['resolved'] = resolved;
    data['resolvedUnacknowledged'] = resolvedUnacknowledged;
    data['preventiveUnacknowledged'] = preventiveUnacknowledged;
    data['predictiveUnacknowledged'] = predictiveUnacknowledged;
    data['total'] = total;
    return data;
  }
}
