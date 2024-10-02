// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryItem {
  final String name;
  final IconData iconData;
  final String screenId;
  final String featureGroup;
  final String? feature;
  final String? permission;

  CategoryItem({
    required this.name,
    required this.iconData,
    required this.screenId,
    required this.featureGroup,
    this.feature,
    this.permission,
  });
}
