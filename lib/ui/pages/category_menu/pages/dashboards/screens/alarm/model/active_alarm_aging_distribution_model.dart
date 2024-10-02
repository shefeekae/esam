class ActiveAlarmAgingBarChartModel {
  ActiveAlarmAgingBarChartModel({
    required this.shutdown,
    required this.critical,
    required this.total,
    required this.title,
    this.entity,
  });

  int shutdown;
  int critical;
  int total;
  String title;
  Map<String, dynamic>? entity;
}
