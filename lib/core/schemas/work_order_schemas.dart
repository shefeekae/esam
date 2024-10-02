class WorkOrderSchema {
  static const String getWorkOrderDetails = '''
query getWorkOrderDetails(\$workOrderId: String!) {
  getWorkOrderDetails(workOrderId: \$workOrderId)
}
''';

  static const String getWorkOrderListData = '''
query getWorkOrderListData(\$data: AssetWorkOrderInput) {
  getWorkOrderListData(data: \$data)
}
''';
}
