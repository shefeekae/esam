class AssetSchema {
  static const String getAssetList = '''
query getAssetList(\$filter: AssetFilter!) {
  getAssetList(filter: \$filter) {
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
      serialNumber
      serviceDue
      sourceId
      thingCode
      thingTagPath
      type
      typeName
      underMaintenance
      warningAlarm
    }
    totalAssetsCount
  }
}
''';

  static const String getAssetTypeImageQuery = '''
query getAssetTypeImage(\$type: String!) {
  getAssetTypeImage(type: \$type)
}
''';

  static const String getUtilizationData = '''
query getUtilizationData(\$payload: MachineDashboardInput!) {
  getUtilizationData(payload: \$payload)
}
''';

  static const String getNotificationCount = '''
query getNotificationsCount(\$payload: MachineCountInput!) {
  getNotificationsCount(payload: \$payload)
}
''';

  static const String getAssetUtilization = '''
query getAssetUtilization(\$startDate: Float!, \$endDate: Float!, \$assets: [Entity!]) {
  getAssetUtilization(startDate: \$startDate, endDate: \$endDate, assets: \$assets) {
    idleDuration
    offDuration
    onDuration
    overtimeIdleDuration
    overtimeOnDuration
    staleDuration
  }
}
''';

  static const String findAssetSchema = '''
query findAsset(\$identifier: String!, \$domain: String!, \$type: String!) {
  findAsset(identifier: \$identifier, domain: \$domain, type: \$type) {
    asset {
      type
      data {
        domain
        name
        identifier
        make
        model
        displayName
        sourceTagPath
        ddLink
        dddLink
        profileImage
        status
        createdOn
        assetCode
        typeName
      }
    }
    parent
    assetLatest {
      name
      clientName
      serialNumber
      dataTime
      underMaintenance
      points
      operationStatus
      path
      location
    }
    criticalPoints {
      type
      data
    }
    lowPriorityPoints {
      type
      data
    }
    settings
  }
}
''';

  static const String listAllNotesQuery = '''
query listAllNotes(\$data: NotesFilter) {
  listAllNotes(data: \$data)
}
''';

  static const String createNoteMutation = '''
mutation createNote(\$notes: NotesInputData!, \$assetCode: String) {
  createNote(notes: \$notes, assetCode: \$assetCode)
}
''';

  static const String assetSettingManualUpdateMutation = '''
mutation assetSettingManualUpdate(\$data: assetSettingManualUpdateInput) {
  assetSettingManualUpdate(data: \$data)
}
''';

  static const String assetsPartsLiveQuery = '''
query assetPartsLive(\$body: AssetPartsInput, \$queryParam: PaginationQueryParam) {
  assetPartsLive(body: \$body, queryParam: \$queryParam) {
    items {
      name
      identifier
      partNumber
      expiryRunhours
      expiryOdometer
      expiryDuration
      remainingOdometer
      remainingRunhours
      remainingTime
      fittedDate
      fittedRunhours
      fittedOdometer
      usedTime
      usedRunhours
      usedOdometer
      totalTime
      totalRunhours
      totalOdometer
    }
    totalItems
    totalPages
    pageItemCount
    currentPage
  }
}
''';

  static const String assetPartsHistoryQuery = '''
query assetPartsHistory(\$body: AssetPartsInput, \$queryParam: PaginationQueryParam) {
  assetPartsHistory(body: \$body, queryParam: \$queryParam) {
    items {
      name
      identifier
      partNumber
      expiryRunhours
      expiryOdometer
      expiryDuration
      fittedDate
      fittedRunhours
      fittedOdometer
      removedDate
      removedRunhours
      removedOdometer
      usedOdometer
      usedRunhours
      usedTime
    }
    totalItems
    totalPages
    pageItemCount
    currentPage
  }
}
''';

  static const String getFirePanels = '''
query getFirePanels(\$data: FirePanelsInput) {
  getFirePanels(data: \$data)
}
''';

  static const String getAssetListCount = '''
query getAssetListCount(\$filter: AssetFilter!) {
  getAssetListCount(filter: \$filter)
}
''';

  static const String markUnderMaintenanceMutation =
      ''' mutation markUnderMaintenance(\$data: MarkUnderMaintenanceInput!) {  markUnderMaintenance(data: \$data)}''';

  static const String listAllPaginatedShifts =
      ''' query listPaginatedShifts(\$queryParam: PaginationQueryParam, \$body: ShiftFilter) {  listPaginatedShifts(queryParam: \$queryParam, body: \$body) {    items {      identifier      name      domain      status      createdBy      createdOn      updatedBy      updatedOn      startTime      endTime      duration      color      textColor      clientName    }    totalItems  }}''';

  static const String listAllOperatorsSchema =
      ''' query listAllOperatorsPaged(\$domain: String!, \$type: String, \$types: [String], \$pagination: PaginationQueryParam, \$name: String, \$assigneeIds: JSON, \$extend: Boolean, \$emailId: String, \$contactNumber: String) {  listAllOperatorsPaged(    domain: \$domain    type: \$type    pagination: \$pagination    name: \$name    types: \$types    assigneeIds: \$assigneeIds    extend: \$extend    emailId: \$emailId    contactNumber: \$contactNumber  )} ''';

  static const String createGroupOverrideRosterMutation =
      ''' mutation createGroupOverrideRoster(\$rosterGroup: [RosterGroupInput]) {  createGroupOverrideRoster(rosterGroup: \$rosterGroup)} ''';

  static const String getAssetOperatorQuery =
      ''' query getAssetOperator(\$identifier: String!) {  getAssetOperator(identifier: \$identifier)} ''';

  static const String getTotalEventConsolidation = '''
query getTotalEventConsolidation(\$data: ConsolidationTotalInput) {
  getTotalEventConsolidation(data: \$data)
}
''';

  static const String getAssetDetailsFromName = '''
query getAssetDetailsFromName(\$assetName: String!, \$domain: String!) {
  getAssetDetailsFromName(assetName: \$assetName, domain: \$domain) {
    sourceTagPath
    equipment {
      type
      data
    }
  }
}
''';

  static const String getAssetTypeImage = '''
query getAssetTypeImage(\$type: String!) {
  getAssetTypeImage(type: \$type)
}
''';

  static const String getAssetAdditionalData = '''
query getAssetAdditionalData(\$assets: [Entity]) {
  getAssetAdditionalData(assets: \$assets) {
    asset
    eventCount
    criticalPoints
  }
}
''';

  static const String getPPMLogs = '''
query getPPMLog(\$asset: Entity!, \$size: Int, \$page: Int, \$startDate: Float, \$endDate: Float, \$sort: String) {
  getPPMLog(
    asset: \$asset
    size: \$size
    page: \$page
    startDate: \$startDate
    endDate: \$endDate
    sort: \$sort
  ) {
    totalItems
    items {
      createdBy
      completedBy
      duration
      endTime
      expectedDuration
      expectedEndTime
      identifier
      notes
      startTime
      status
      workOrderId
      workOrderNo
      jobId
      id
      createdNote
      completedNote
    }
  }
}
''';

  static const String listServedByAssetsWithLatestData = '''
query listServedByAssetsWithLatestData(\$data: AssetPaginationInput) {
  listServedByAssetsWithLatestData(data: \$data) {
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

  static const String listServingToAssetsWithLatestData = '''
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

  static const String listServingSpaces = '''
query listServingSpaces(\$asset: Entity) {
  listServingSpaces(asset: \$asset)
}
''';
}
