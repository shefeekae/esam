// To parse this JSON data, do
//
//     final documentsFilterModel = documentsFilterModelFromJson(jsonString);

import 'dart:convert';

List<DocumentsFilterModel> documentsFilterModelFromJson(List<Map<String,dynamic>> list) =>
    List<DocumentsFilterModel>.from(
        (list.map((x) => DocumentsFilterModel.fromJson(x))));

String documentsFilterModelToJson(List<DocumentsFilterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocumentsFilterModel {
  DocumentsFilterModel({
    this.label,
    this.name,
    this.aliasName,
    this.type,
    this.options,
    this.additionalProps,
    this.apiCallNeeded,
    this.fieldsToClear,
    this.enableLoadMore,
    this.enableKeywordSearch,
  });

  String? label;
  String? name;
  String? aliasName;
  String? type;
  List<Option>? options;
  AdditionalProps? additionalProps;
  bool? apiCallNeeded;
  List<String>? fieldsToClear;
  bool? enableLoadMore;
  bool? enableKeywordSearch;

  factory DocumentsFilterModel.fromJson(Map<String, dynamic> json) =>
      DocumentsFilterModel(
        label: json["label"],
        name: json["name"],
        aliasName: json["aliasName"],
        type: json["type"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        additionalProps: json["additionalProps"] == null
            ? null
            : AdditionalProps.fromJson(json["additionalProps"]),
        apiCallNeeded: json["apiCallNeeded"],
        fieldsToClear: json["fieldsToClear"] == null
            ? []
            : List<String>.from(json["fieldsToClear"]!.map((x) => x)),
        enableLoadMore: json["enableLoadMore"],
        enableKeywordSearch: json["enableKeywordSearch"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "name": name,
        "aliasName": aliasName,
        "type": type,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "additionalProps": additionalProps?.toJson(),
        "apiCallNeeded": apiCallNeeded,
        "fieldsToClear": fieldsToClear == null
            ? []
            : List<dynamic>.from(fieldsToClear!.map((x) => x)),
        "enableLoadMore": enableLoadMore,
        "enableKeywordSearch": enableKeywordSearch,
      };
}

class AdditionalProps {
  AdditionalProps({
    this.showSearch,
    this.placeholder,
    this.allowClear,
  });

  bool? showSearch;
  String? placeholder;
  bool? allowClear;

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

class Option {
  Option({
    this.label,
    this.value,
  });

  String? label;
  String? value;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
