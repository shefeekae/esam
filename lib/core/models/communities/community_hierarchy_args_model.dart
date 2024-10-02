// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/enums/insights_enum.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';

class CommunityHierarchyArgs {
  final Insights insights;
  final String? communityIdentifier;
  final CommunityHierarchyDropdownData? dropdownData;
  final DateTimeRange? initialDateTimeRange;

  CommunityHierarchyArgs({
    required this.insights,
    this.dropdownData,
    this.communityIdentifier,
    this.initialDateTimeRange,
  });
}
