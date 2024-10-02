class FirePanelSchema {
  static const String getFirePanelsAlarmsGroupedBy = '''
query getFirePanelsAlarmsGroupedBy(\$data: FirePanelsGroupedByInput) {
  getFirePanelsAlarmsGroupedBy(data: \$data)
}
''';

  static const String getFirePanelsAlarmsAgeing = '''
query getFirePanelsAlarmsAgeing(\$data: FirePanelsAgeingInput) {
  getFirePanelsAlarmsAgeing(data: \$data)
}
''';
}
