class CommonSchema {
  static const String getSearchData = '''
query getSearchData(\$data: GlobalSearchInput) {
  getSearchData(data: \$data)
}
''';

  static const String getUtilitiesSpaceDistributionData = '''
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
}
