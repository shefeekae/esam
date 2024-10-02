// To parse this JSON data, do
//
//     final alarmsFilterModel = alarmsFilterModelFromJson(jsonString);

import 'dart:convert';

List<AlarmsFilterModel> alarmsFilterModelFromJson(
    List<Map<String, dynamic>> list) {
  return list.map((e) => AlarmsFilterModel.fromJson(e)).toList();
}

String alarmsFilterModelToJson(List<AlarmsFilterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlarmsFilterModel {
  AlarmsFilterModel({
    required this.label,
    required this.name,
    required this.aliasName,
    required this.type,
    required this.options,
    this.apiCallNeeded,
    this.showFor,
    this.additionalProps,
    this.fieldsToClear,
    this.enableLoadMore,
    this.enableKeywordSearch,
    this.customType,
  });

  String label;
  String name;
  String aliasName;
  String type;
  List<AlarmsFilterModelOption> options;
  bool? apiCallNeeded;
  String? showFor;
  AdditionalProps? additionalProps;
  List<String>? fieldsToClear;
  bool? enableLoadMore;
  bool? enableKeywordSearch;
  String? customType;

  factory AlarmsFilterModel.fromJson(Map<String, dynamic> json) =>
      AlarmsFilterModel(
        label: json["label"],
        name: json["name"],
        aliasName: json["aliasName"],
        type: json["type"],
        options: List<AlarmsFilterModelOption>.from(
            json["options"].map((x) => AlarmsFilterModelOption.fromJson(x))),
        apiCallNeeded: json["apiCallNeeded"],
        showFor: json["showFor"],
        additionalProps: json["additionalProps"] == null
            ? null
            : AdditionalProps.fromJson(json["additionalProps"]),
        fieldsToClear: json["fieldsToClear"] == null
            ? []
            : List<String>.from(json["fieldsToClear"]!.map((x) => x)),
        enableLoadMore: json["enableLoadMore"],
        enableKeywordSearch: json["enableKeywordSearch"],
        customType: json["customType"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "name": name,
        "aliasName": aliasName,
        "type": type,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "apiCallNeeded": apiCallNeeded,
        "showFor": showFor,
        "additionalProps": additionalProps?.toJson(),
        "fieldsToClear": fieldsToClear == null
            ? []
            : List<dynamic>.from(fieldsToClear!.map((x) => x)),
        "enableLoadMore": enableLoadMore,
        "enableKeywordSearch": enableKeywordSearch,
        "customType": customType,
      };
}

class AdditionalProps {
  AdditionalProps({
    required this.showSearch,
    required this.placeholder,
    required this.allowClear,
  });

  bool showSearch;
  String placeholder;
  bool allowClear;

  factory AdditionalProps.fromJson(Map<String, dynamic> json) =>
      AdditionalProps(
        showSearch: json["showSearch"],
        placeholder: json["placeholder"],
        allowClear: json["allowClear"],
      );

  Map<String, dynamic> toJson() => {
        "showSearch": showSearch,
        "placeholder": placeholder,
        "allowClear": allowClear,
      };
}

class AlarmsFilterModelOption {
  AlarmsFilterModelOption({
    required this.label,
    this.value,
    this.type,
    this.name,
    this.aliasName,
    this.options,
  });

  String label;
  String? value;
  String? type;
  String? name;
  String? aliasName;
  List<OptionOption>? options;

  factory AlarmsFilterModelOption.fromJson(Map<String, dynamic> json) =>
      AlarmsFilterModelOption(
        label: json["label"],
        value: json["value"],
        type: json["type"],
        name: json["name"],
        aliasName: json["aliasName"],
        options: json["options"] == null
            ? []
            : List<OptionOption>.from(
                json["options"]!.map((x) => OptionOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "type": type,
        "name": name,
        "aliasName": aliasName,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class OptionOption {
  OptionOption({
    required this.label,
    required this.value,
  });

  String label;
  String value;

  factory OptionOption.fromJson(Map<String, dynamic> json) => OptionOption(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
