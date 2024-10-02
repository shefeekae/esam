// ignore_for_file: public_member_api_docs, sort_constructors_first
class FilterModel {
  String label;
  String type;
  String key;
  bool apiCallNeeded;
  List<Options> options;

  FilterModel({
    required this.label,
    required this.type,
    required this.key,
    this.apiCallNeeded = true,
    this.options = const [],
  });
}

class Options {
  String label;
  String value;
  String type;
  String aliasName;
  List<Options> groups;

  Options({
    required this.label,
    required this.value,
    required this.type,
    this.aliasName = "",
    this.groups = const [],
  });
}

class FilterValueModel {
  String identifier;
  String? type;
  String title;
  FilterValueModel({
    required this.identifier,
    this.type,
    required this.title,
  });
}

class FilterValue {
  String key;
  // String label;
  List<SelectedValue> selectedValues = [];
  // String type;
  // bool apiCallNeeded;

  FilterValue({
    required this.key,
    required this.selectedValues,
    // required this.label,
    // required this.type,
    // required this.apiCallNeeded,
  });
}

class SelectedValue {
  String name;
  String identifier;
  String? type;
  String aliasName;

  SelectedValue({
    required this.name,
    required this.identifier,
    this.aliasName = "",
    this.type,
  });
}
