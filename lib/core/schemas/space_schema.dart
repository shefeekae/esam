class SpaceSchema {
  static const listAllSpacesPagination = '''

query listAllSpacesPagination(\$data: SpacesInput!) {\n  listAllSpacesPagination(data: \$data) {\n    space {\n      type\n      data\n    }\n    site\n    subCommunity\n  }\n}\n

''';

  static const String getSpaceInsightVisualization = '''
query getSpaceInsightVisualization(\$data: VisualizationInput!) {
  getSpaceInsightVisualization(data: \$data)
}
''';
}
