class DocumentSchema {
  static const String getDocumentListQuery = '''
query getDocumentsList(\$data: DocumentFilter) {
  getDocumentsList(data: \$data) {
    result {
      document {
        type
        data
      }
      documentCategory
      assetCount
    }
    totalDocumentCount
  }
}
''';

  static const String getFilePreviewQuery = '''
query getFileForPreview(\$fileName: String!, \$filePath: String!,\$isJSON: Boolean) {
  getFileForPreview(fileName: \$fileName, filePath: \$filePath, isJSON: \$isJSON)
}
''';

  static const String getMappedEntitiesWithDocumentLatestDataQuery = '''
query getMappedEntitiesWithDocumentLatestData(\$data: AssetPaginationInput) {
  getMappedEntitiesWithDocumentLatestData(data: \$data) {
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
      typeName
      underMaintenance
      warningAlarm
    }
    totalAssetsCount
  }
}
''';
}
