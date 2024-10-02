
class DailyDistributionDayDataModel {
  DateTime dateTime;
  int totalCount;
  int criticalCount;
  int resolvedCount;

  DailyDistributionDayDataModel({
    required this.dateTime,
    required this.totalCount,
    required this.criticalCount,
    required this.resolvedCount,
  });
}
