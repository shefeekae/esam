class DashboardSchema {
  static const getAlarmLifeTimeDistributionData = '''
query getAlarmLifeTimeDistributionData(\$data: LifeTimeDistributionInput) {
  getAlarmLifeTimeDistributionData(data: \$data) {
    alarms {
      date
      total
      active
    }
    onboard {
      type
      data
    }
  }
} 
''';

  static const getAlarmAgeingData = ''' 
 query getAlarmAgeingData(\$data: AlarmAgeingInput) {
  getAlarmAgeingData(data: \$data)
}
 ''';

  static const getAlarmConsolidationDataByDate = '''
query getAlarmConsolidationDataByDate(\$data: ConsolidationByDateInput) {
  getAlarmConsolidationDataByDate(data: \$data) {
    results {
      field {
        field
        count
        value
      }
      pivots
    }
  }
}

''';

  static const getTypeEventConsolidation = '''

query getTypeEventConsolidation(\$data: ConsolidationTotalInput) {
  getTypeEventConsolidation(data: \$data)
}

''';

  static const getTotalEventConsolidation = ''' 
  
  query getTotalEventConsolidation(\$data: ConsolidationTotalInput) {
  getTotalEventConsolidation(data: \$data)
}
  
   ''';

  static const getLevelBasedEventConsolidation = '''
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

  static const getUtilitiesData = ''' 
query getUtilitiesData(\$data: UtilitiesDataInput) {
  getUtilitiesData(data: \$data) {
    latestUpdate {
      year
      month
    }
    values {
      name
      month
      LVPMeterCurrent
      LVPMeterPrevious
      LVPMeterCurrentCost
      LVPMeterPreviousCost
      LVPSubMeterCurrent
      LVPSubMeterPrevious
      LVPSubMeterCurrentCost
      LVPSubMeterPreviousCost
      DCPBTUMeterCurrent
      DCPBTUMeterPrevious
      DCPBTUMeterCurrentCost
      DCPBTUMeterPreviousCost
      WaterMeterCurrent
      WaterMeterPrevious
      WaterMeterCurrentCost
      WaterMeterPreviousCost
      TSEMeterCurrent
      TSEMeterPrevious
      TSEMeterCurrentCost
      TSEMeterPreviousCost
    }
  }
}
''';

  static const getUtilitiesSpaceDistributionData = '''
query getUtilitiesSpaceDistributionData(\$data: UtilitiesSpaceDistributionDataInput) {
  getUtilitiesSpaceDistributionData(data: \$data) {
    label
    value
    data {
      type
      data
    }
    premiseNumber
  }
}
''';

  static const getSubMetersList = '''
query getSubMetersList(\$site: Entity!) {
  getSubMetersList(site: \$site) {
    child
    grandchildren
  }
}
''';

  static const listServingToAssetsWithLatestData = ''' 
  query listServingToAssetsWithLatestData(\$data: AssetPaginationInput) {
  listServingToAssetsWithLatestData(data: \$data) {
    assets {
      category
      clientDomain
      clientName
      communicationStatus
      createdOn
      criticalAlarm
      dataTime
      displayName
      documentExpire
      documentExpiryTypes
      domain
      highAlarm
      id
      identifier
      lastCommunicated
      location
      locationJson
      lowAlarm
      make
      mediumAlarm
      model
      name
      operationStatus
      overtime
      owners
      ownersJson
      path
      points
      pointsJson
      reason
      recent
      serviceDue
      sourceId
      thingCode
      thingTagPath
      type
      underMaintenance
      warningAlarm
    }
    totalAssetsCount
  }
}
  ''';
}
