class ServiceSchema {
  static const String listPendingServiceLogs = '''
query listPendingServiceLogs(\$data: PendingServiceInput, \$queryParam: PaginationQueryParam) {
  listPendingServiceLogs(data: \$data, queryParam: \$queryParam) {
    items {
      service
      asset
    }
    totalItems
    totalPages
    pageItemCount
    currentPage
  }
}
''';

  static const String getLogsServices = '''
query getServiceLog(\$data: ServiceLogInput, \$queryParam: PaginationQueryParam) {
  getServiceLog(data:\$data, queryParam: \$queryParam)
}
''';

  static const String getLogsServiceDetails = '''
query findServiceLogDetails(\$identifier: String!) {
  findServiceLogDetails(identifier: \$identifier) {
    serviceLog
    assignee {
      name
    }
    checklist {
      checked
      serviceCheckList {
        name
      }
    }
    parts {
      quantity
      fittedRunhours
      fittedOdometer
      part {
        name
        partReference
      }
    }
    taggedService
  }
}
''';

  static const String getAllFilesFromSamePathQuery = '''
query getAllFilesFromSamePath(\$filePath: String!, \$isJSON: Boolean) {
  getAllFilesFromSamePath(filePath: \$filePath, isJSON: \$isJSON)
}
''';



 
}
