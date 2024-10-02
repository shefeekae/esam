// ignore_for_file: public_member_api_docs, sort_constructors_first
class EquipmentConsoldationModel {
  final String assetName;
  final int activeCount;
  final int resolvedCount;
  final int? percentage;
  
  EquipmentConsoldationModel({
    required this.assetName,
    required this.activeCount,
    required this.resolvedCount,
    this.percentage,
  });
  
}
