class FilesSchemas {
  // ================================================================================

  static const String uploadMultipleFilesMutation = '''
mutation uploadMultipleFiles(\$data : [MultipleFiles]){
  uploadMultipleFiles(data: \$data)
}
''';
}
