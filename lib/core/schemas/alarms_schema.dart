class AlarmsSchema {
  static const String listAlarmsQuery = '''
query listAlarms(\$filter: AlarmsFilter!) {
  listAlarms(filter: \$filter) {
    count
    eventLogs {
      name
      type
      group
      criticality
      sourceId
      sourceType
      sourceTypeName
      sourceName
      eventTime
      eventDay
      activeMessage
      suspectData
      active
      recurring
      resolved
      resolvedTime
      eventId
      acknowledged
      sourceDomain
      eventDomain
      clientDomain
      clientName
      actionRequired
      actioned
      assetCode
      sourceTagPath
      issue
      action
      suggestion
      configurationId
      delay
      annotations
      tagids
      workOrderId
      workOrderNo
      location
    }
  }
}

''';

  static const String getEventDetails = '''
query getEventDetails(\$identifier: String!, \$multipleAssetAlarms: Boolean) {
  getEventDetails(
    identifier: \$identifier
    multipleAssetAlarms: \$multipleAssetAlarms
  )
}

''';

  static const String alarmsDiagnosisDetailsQuery = '''
query getEventDetailDiagnosis(\$data: AlarmDiagnosisInput!) {
  getEventDetailDiagnosis(data: \$data)
}
''';

  static const String alarmsCountQuery = '''
query getAlarmCount(\$filter: AlarmsFilter!) {
  getAlarmCount(filter: \$filter)
}
''';

  static const String getAssetAlarmsStatisticsDataSchema =
      '''query getAssetAlarmsStatisticsData(\$brand: String!) {  getAssetAlarmsStatisticsData(brand: \$brand)}''';

  static const String getTotalEventConsolidation = '''
query getTotalEventConsolidation(\$data: ConsolidationTotalInput) {
  getTotalEventConsolidation(data: \$data)
}
''';

  static const String getInsightsData = '''
query getInsightsData(\$filter: AlarmsFilter!) {
  getInsightsData(filter: \$filter)
}
''';

  static const String getAssetHistory = '''
query getAssetHistory(\$data: AssetHistoryInput!) {
  getAssetHistory(data: \$data)
}
''';

  static const String getComments = '''
query getComments(\$identifier: String!) {
  getComments(identifier: \$identifier)
}
''';

  static const String addComment = '''
mutation addComment(\$payload: CommentInput!) {
  addComment(payload: \$payload)
}
''';

  static const String findMitigationReport = '''
query findMitigationReport(\$eventId: String!) {
  findMitigationReport(eventId: \$eventId) {
    id
    steps {
      mitigationStepId
      title
      name
      remark
      successItems
      failedItems
      executionStatus
      terminateOnFailure
      executionTime
    }
  }
}
''';

  static const String getLiveData = '''
query getLiveData(\$id: String!) {
  getLiveData(id: \$id) {
    dataTime
    points {
      pointId
      pointName
      data
      unit
      accessType
      dataType
      pointAccessType
      status
    }
  }
}
''';

  static const String getEventDetailDiagnosis = '''
query getEventDetailDiagnosis(\$data: AlarmDiagnosisInput!) {
  getEventDetailDiagnosis(data: \$data)
}
''';

  static const String searchEvent = '''
query searchEvent(\$data: EventSearch) {
  searchEvent(data: \$data)
}
''';

  static const String acknowledgeAlarms = '''
mutation acknowledgeAlarms(\$data: [AcknowledgeInput]!) {
  acknowledgeAlarms(data: \$data)
}
''';

  static const String getAlarmDiagnosis = '''
query getAlarmDiagnosis(\$data: AlarmDiagnosisInput!) {
  getAlarmDiagnosis(data: \$data)
}
''';

  static const String getConsumptionComparison = '''
query getConsumptionComparison(\$data: ConsumptionComparisonInput!) {
  getConsumptionComparison(data: \$data) {
    period {
      dateTime
      consumption
      year
      month
    }
    comparePeriod {
      dateTime
      consumption
      year
      month
    }
    stats {
      min
      max
      avg
      sum
    }
    benchMark
  }
}
''';

  static const String getSystemGeneratedAlarmData = '''
query getSystemGeneratedAlarmData(\$brand: String!) {
  getSystemGeneratedAlarmData(brand: \$brand)
}
''';

  static const String normalizeAlarm = '''
mutation forceNormalizeEvent(\$data: [ForceNormalizeEventInput]!) {
  forceNormalizeEvent(data: \$data)
}
''';

  static const String temporarilyDisableEvent = '''
mutation temporarilyDisableEvent(\$data: TemporarilyDisableEventInput!) {
  temporarilyDisableEvent(data: \$data)
}
''';

  static const String getAlarmCount =
      ''' query getAlarmCount(\$filter: AlarmsFilter!) {\n  getAlarmCount(filter: \$filter)\n}\n  ''';
}
