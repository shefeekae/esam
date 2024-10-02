class FilterSchemas {
  static const String clientJson = '''
query findAllClients(\$domain: String!, \$type: String, \$loop: Boolean, \$strict: Boolean) {
  findAllClients(domain: \$domain, type: \$type, loop: \$loop, strict: \$strict)
}
''';

  static const String assetTypesJson = '''
query listAllAssetTypes(\$domain: String!, \$type: String!) {
  listAllAssetTypes(domain: \$domain, type: \$type) {
    domain
    name
    parent
    templateName
  }
}
''';

  static const String locationJson = '''
query listAllGeoFences(\$data: geofenceList) {
  listAllGeoFences(data: \$data) {
    data {
      type
      data
    }
    totalCount
  }
}
''';

  static const String parentTypeJson = '''
query listAllTemplatesSystem(\$domain: String!, \$name: String!) {
  listAllTemplatesSystem(domain: \$domain, name: \$name) {
    name
    templateName
    parent
    domain
  }
}
''';

  static const String getDocumentCategoriesQuery = '''
query getDocumentCategories(\$domain: String) {
  getDocumentCategories(domain: \$domain) {
    type
    data
  }
}
''';
}
