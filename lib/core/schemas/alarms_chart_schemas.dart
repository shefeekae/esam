class AlarmChartSchemas {
  static const String getAlarmAgeingData = '''
query getAlarmAgeingData(\$data: AlarmAgeingInput) {
  getAlarmAgeingData(data: \$data)
}
''';

  static const String getTypeEventConsolidation = '''
query getTypeEventConsolidation(\$data: ConsolidationTotalInput) {
  getTypeEventConsolidation(data: \$data)
}
''';

  static const String getLevelBasedEventConsolidation = '''
query getLevelBasedEventConsolidation(\$data: LevelBasedConsolidationInput) {
  getLevelBasedEventConsolidation(data: \$data) {
    level
    eventCounts {
      equipmentConsolidation {
        field
        count
      }
      entity {
        type
        data
      }
      count
    }
  }
}
''';
}
