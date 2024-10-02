// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nectar_assets/core/models/filter_model.dart';

class FilterAppliedModel {
  String key;
  List<SelectedValue> selectedValues = [];

  FilterAppliedModel({
    required this.key,
    required this.selectedValues,
  });
}
