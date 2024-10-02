class CommunityHierarchyDropdownData {
  String displayName;
  String identifier;
  Map<String, dynamic> entity;
  String? defaultValue;
  String? locationName;
  String? typeName;
  Map<String, dynamic>? parentEntity;

  CommunityHierarchyDropdownData({
    required this.displayName,
    required this.entity,
    required this.identifier,
    required this.parentEntity,
    this.defaultValue,
    this.locationName,
    this.typeName,
  });
}
