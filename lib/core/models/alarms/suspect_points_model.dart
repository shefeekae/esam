// ignore_for_file: public_member_api_docs, sort_constructors_first
class SuspectPointsTableDataModel {
  final String? pointName;
  final String? alarmData;
  final String? currentData;
  final String? status;
  SuspectPointsTableDataModel({
    this.pointName,
    this.alarmData,
    this.currentData,
    this.status,
  });

  factory SuspectPointsTableDataModel.fromJson(Map<String, dynamic>? map) {
    return SuspectPointsTableDataModel(
      pointName: map?['pointName'],
      alarmData: map?['alarmData'],
      currentData: map?['data'] == null ? "" : map?['data'].toString(),
      status: map?['status'],
    );
  }
}
