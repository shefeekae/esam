class SearchEventsSchemea {
  static const String alarmsSearchJson = '''
query searchEvent(\$data: EventSearch) {
  searchEvent(data: \$data)
}
''';
}
