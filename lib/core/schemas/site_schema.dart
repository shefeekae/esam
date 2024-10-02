class SiteSchema {
  static const String listAllSitesHasAlarm = '''
query listAllSitesHasAlarm(\$siteGroup: UserRestrictedSiteInput!) {
  listAllSitesHasAlarm(siteGroup: \$siteGroup) {
    type
    data
  }
}
''';

  static const String findAllBuildings = ''' 
  query findAllBuildings(\$domain: String!, \$subCommunity: Entity, \$type: String, \$subCommunities: [Entity]) {
  findAllBuildings(
    domain: \$domain
    subCommunity: \$subCommunity
    type: \$type
    subCommunities: \$subCommunities
  ) {
    type
    data
  }
}
''';

  static const String findSite = '''
query findSite(\$site: Entity!) {
  findSite(site: \$site) {
    site {
      type
      data
    }
    siteGroup {
      type
      data
    }
    bmsContact
    fmsContact
    associationManagerContact
    securityContact
  }
}
''';

  static const String getSiteForecast = '''
query getSiteForecast(\$id: String!, \$startDate: Float, \$endDate: Float) {
  getSiteForecast(id: \$id, startDate: \$startDate, endDate: \$endDate)
}
''';

  static const String getSiteInsightVisualization = '''
query getSiteInsightVisualization(\$data: VisualizationInput!) {
  getSiteInsightVisualization(data: \$data)
}
''';

  static const String findAllSpacesOfSite = '''
query findAllSpacesOfSite(\$site: Entity!, \$spaceType: String) {
  findAllSpacesOfSite(site: \$site, spaceType: \$spaceType) {
    type
    data
  }
}
''';
}
