class SubCommunitySchema {
  static const String listAllSiteGroupsHasAlarm = '''
query listAllSiteGroupsHasAlarm(\$domain: String!) {
  listAllSiteGroupsHasAlarm(domain: \$domain) {
    type
    data
  }
}
''';

  static const String findAllSubCommunities = '''
query findAllSubCommunities(\$domain: String!) {
  findAllSubCommunities(domain: \$domain) {
    type
    data
  }
}
''';

  static const String getSubCommunityForecast = '''
query getSubCommunityForecast(\$id: String!, \$startDate: Float, \$endDate: Float) {
  getSubCommunityForecast(id: \$id, startDate: \$startDate, endDate: \$endDate)
}
''';
}
