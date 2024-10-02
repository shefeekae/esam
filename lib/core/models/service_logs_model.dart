// To parse this JSON data, do
//
//     final logsServiceModel = logsServiceModelFromJson(jsonString);

import 'dart:convert';

LogsServiceModel logsServiceModelFromJson(Map<String, dynamic> map) =>
    LogsServiceModel.fromJson(map);

String logsServiceModelToJson(LogsServiceModel data) =>
    json.encode(data.toJson());

class LogsServiceModel {
  LogsServiceModel({
    this.listPendingServiceLogs,
  });

  ListPendingServiceLogs? listPendingServiceLogs;

  factory LogsServiceModel.fromJson(Map<String, dynamic> json) =>
      LogsServiceModel(
        listPendingServiceLogs: json["listPendingServiceLogs"] == null
            ? null
            : ListPendingServiceLogs.fromJson(json["listPendingServiceLogs"]),
      );

  Map<String, dynamic> toJson() => {
        "listPendingServiceLogs": listPendingServiceLogs?.toJson(),
      };
}

class ListPendingServiceLogs {
  ListPendingServiceLogs({
    this.items,
    this.totalItems,
    this.totalPages,
    this.pageItemCount,
    this.currentPage,
  });

  List<Item>? items;
  int? totalItems;
  int? totalPages;
  int? pageItemCount;
  int? currentPage;

  factory ListPendingServiceLogs.fromJson(Map<String, dynamic> json) =>
      ListPendingServiceLogs(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        pageItemCount: json["pageItemCount"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItems": totalItems,
        "totalPages": totalPages,
        "pageItemCount": pageItemCount,
        "currentPage": currentPage,
      };
}

class Item {
  Item({
    this.service,
    this.asset,
  });

  Service? service;
  Asset? asset;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        asset: json["asset"] == null ? null : Asset.fromJson(json["asset"]),
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "asset": asset?.toJson(),
      };
}

class Asset {
  Asset({
    this.identifier,
    this.type,
    this.displayName,
    this.make,
    this.model,
    this.status,
    this.domain,
    this.domainName,
    // this.clientId,
    this.clientName,
  });

  String? identifier;
  AssetType? type;
  String? displayName;
  String? make;
  String? model;
  Status? status;
  String? domain;
  String? domainName;
  // ClientId? clientId;
  String? clientName;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        identifier: json["identifier"],
        type: json["type"] == null ? null : AssetType.fromJson(json["type"]),
        displayName: json["displayName"],
        make: json["make"],
        model: json["model"],
        // status: json['status'],
        // status: statusValues.map[json["status"]]!,
        // domain: json["domain"]!,
        domainName: json["domainName"],
        // clientId: clientIdValues.map[json["clientId"]]!,
        clientName: json["clientName"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "type": type?.toJson(),
        "displayName": displayName,
        "make": make,
        "model": model,
        "status": statusValues.reverse[status],
        // "domain": clientIdValues.reverse[domain],
        "domainName": domainName,
        // "clientId": clientIdValues.reverse[clientId],
        "clientName": clientName,
      };
}

// enum ClientId { MACHINEDEMO, GGE }

// final clientIdValues =
//     EnumValues({"gge": ClientId.GGE, "machinedemo": ClientId.MACHINEDEMO});

enum Status { ACTIVE }

final statusValues = EnumValues({"ACTIVE": Status.ACTIVE});

class AssetType {
  AssetType({
    this.name,
    this.templateName,
    this.parentName,
    this.status,
  });

  String? name;
  String? templateName;
  String? parentName;
  Status? status;

  factory AssetType.fromJson(Map<String, dynamic> json) => AssetType(
        name: json["name"],
        templateName: json["templateName"],
        parentName: json["parentName"],
        // status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "templateName": templateName,
        "parentName": parentName,
        "status": statusValues.reverse[status],
      };
}

class Service {
  Service({
    this.identifier,
    this.domain,
    this.name,
    this.nextServiceOdometer,
    this.nextServiceRunHours,
    this.proposedServiceTime,
    this.serviceStatus,
    this.cyclicCount,
    this.checklist,
    this.parts,
    this.taggedService,
    this.serviceTyp,
    this.actRunHours,
    this.expRunHours,
    this.dueDate,
  });

  String? identifier;
  String? domain;
  String? name;
  dynamic nextServiceOdometer;
  dynamic nextServiceRunHours;
  dynamic proposedServiceTime;
  String? serviceStatus;
  int? cyclicCount;
  List<Checklist>? checklist;
  List<PartElement>? parts;
  TaggedService? taggedService;
  String? serviceTyp;
  dynamic expRunHours;
  dynamic actRunHours;
  int? dueDate;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        dueDate: json['dueDate'],
        identifier: json["identifier"],
        domain: json['domain'],
        // domain: clientIdValues.map[json["domain"]]!,
        name: json["name"],
        nextServiceOdometer: json["nextServiceOdometer"],
        nextServiceRunHours: json["nextServiceRunHours"],
        proposedServiceTime: json["proposedServiceTime"],
        serviceStatus: json["serviceStatus"]!,
        cyclicCount: json["cyclicCount"],
        checklist: json["checklist"] == null
            ? []
            : List<Checklist>.from(
                json["checklist"]!.map((x) => Checklist.fromJson(x))),
        parts: json["parts"] == null
            ? []
            : List<PartElement>.from(
                json["parts"]!.map((x) => PartElement.fromJson(x))),
        taggedService: json["taggedService"] == null
            ? null
            : TaggedService.fromJson(json["taggedService"]),
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        // "domain": clientIdValues.reverse[domain],
        "name": name,
        "nextServiceOdometer": nextServiceOdometer,
        "nextServiceRunHours": nextServiceRunHours,
        "proposedServiceTime": proposedServiceTime,
        "serviceStatus": serviceStatusValues.reverse[serviceStatus],
        "cyclicCount": cyclicCount,
        "checklist": checklist == null
            ? []
            : List<dynamic>.from(checklist!.map((x) => x.toJson())),
        "parts": parts == null
            ? []
            : List<dynamic>.from(parts!.map((x) => x.toJson())),
        // "taggedService": taggedService?.toJson(),
      };
}

class Checklist {
  Checklist({
    this.identifier,
    this.name,
    this.description,
    this.criticality,
    this.status,
    this.createdBy,
    this.createdOn,
    this.types,
    // this.domain,
    this.updatedBy,
    this.updatedOn,
  });

  String? identifier;
  String? name;
  String? description;
  Criticality? criticality;
  Status? status;
  CreatedBy? createdBy;
  int? createdOn;
  List<TypeElement>? types;
  // ClientId? domain;
  String? updatedBy;
  int? updatedOn;

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        identifier: json["identifier"],
        name: json["name"],
        description: json["description"],
        // criticality: criticalityValues.map[json["criticality"]]!,
        // status: statusValues.map[json["status"]]!,
        // createdBy: createdByValues.map[json["createdBy"]]!,
        createdOn: json["createdOn"],
        types: json["types"] == null
            ? []
            : List<TypeElement>.from(
                json["types"]!.map((x) => TypeElement.fromJson(x))),
        // domain: clientIdValues.map[json["domain"]]!,
        // updatedBy: json["updatedBy"],
        // updatedOn: json["updatedOn"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "description": description,
        "criticality": criticalityValues.reverse[criticality],
        "status": statusValues.reverse[status],
        "createdBy": createdByValues.reverse[createdBy],
        "createdOn": createdOn,
        "types": types == null
            ? []
            : List<dynamic>.from(types!.map((x) => x.toJson())),
        // "domain": clientIdValues.reverse[domain],
        "updatedBy": updatedBy,
        "updatedOn": updatedOn,
      };
}

enum CreatedBy { SUPPORT_MACHINEDEMO, RIYAS_NECTARIT }

final createdByValues = EnumValues({
  "riyas@nectarit": CreatedBy.RIYAS_NECTARIT,
  "support@machinedemo": CreatedBy.SUPPORT_MACHINEDEMO
});

enum Criticality { LOW, MEDIUM, HIGH }

final criticalityValues = EnumValues({
  "HIGH": Criticality.HIGH,
  "LOW": Criticality.LOW,
  "MEDIUM": Criticality.MEDIUM
});

class TypeElement {
  TypeElement({
    this.type,
    this.templateName,
    this.exclusive,
  });

  TypeEnum? type;
  TemplateName? templateName;
  bool? exclusive;

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        // type: typeEnumValues.map[json["type"]]!,
        // templateName: templateNameValues.map[json["templateName"]]!,
        exclusive: json["exclusive"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeEnumValues.reverse[type],
        "templateName": templateNameValues.reverse[templateName],
        "exclusive": exclusive,
      };
}

enum TemplateName {
  LEE_BOY_BACKHOE_LOADER_XXX,
  HYUNDAI_EXCAVATOR_CRAWLER_290_LC_7_A,
  HYUNDAI_EXCAVATOR_CRAWLER_R500_LC_7
}

final templateNameValues = EnumValues({
  "Hyundai Excavator Crawler 290LC-7A":
      TemplateName.HYUNDAI_EXCAVATOR_CRAWLER_290_LC_7_A,
  "Hyundai Excavator Crawler R500LC-7":
      TemplateName.HYUNDAI_EXCAVATOR_CRAWLER_R500_LC_7,
  "LeeBoy Backhoe Loader XXX": TemplateName.LEE_BOY_BACKHOE_LOADER_XXX
});

enum TypeEnum {
  LEE_BOY_BACKHOE_LOADER_XXX,
  HYUNDAI_EXCAVATOR_CRAWLER290_LC7_A,
  HYUNDAI_EXCAVATOR_CRAWLER_R500_LC7
}

final typeEnumValues = EnumValues({
  "HyundaiExcavatorCrawler290LC7A": TypeEnum.HYUNDAI_EXCAVATOR_CRAWLER290_LC7_A,
  "HyundaiExcavatorCrawlerR500LC7": TypeEnum.HYUNDAI_EXCAVATOR_CRAWLER_R500_LC7,
  "LeeBoyBackhoeLoaderXXX": TypeEnum.LEE_BOY_BACKHOE_LOADER_XXX
});

class PartElement {
  PartElement({
    this.identifier,
    this.partPart,
    this.quantity,
  });

  String? identifier;
  PartPart? partPart;
  int? quantity;

  factory PartElement.fromJson(Map<String, dynamic> json) => PartElement(
        identifier: json["identifier"],
        partPart: json["part"] == null ? null : PartPart.fromJson(json["part"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "part": partPart?.toJson(),
        "quantity": quantity,
      };
}

class PartPart {
  PartPart({
    this.identifier,
    this.name,
    this.description,
    this.partReference,
    this.unitCost,
    // this.unit,
    // this.status,
    this.types,
    this.odometer,
    this.createdBy,
    this.createdOn,
    // this.domain,
    this.runhours,
  });

  String? identifier;
  String? name;
  String? description;
  String? partReference;
  num? unitCost;
  // Unit? unit;
  // Status? status;
  List<TypeElement>? types;
  num? odometer;
  CreatedBy? createdBy;
  int? createdOn;
  // ClientId? domain;
  num? runhours;

  factory PartPart.fromJson(Map<String, dynamic> json) => PartPart(
        identifier: json["identifier"],
        name: json["name"],
        description: json["description"],
        partReference: json["partReference"],
        unitCost: json["unitCost"],
        // unit: unitValues.map[json["unit"]]!,
        // status: statusValues.map[json["status"]]!,
        // types: json["types"] == null
        //     ? []
        //     : List<TypeElement>.from(
        // json["types"]!.map((x) => TypeElement.fromJson(x))),
        // odometer: json["odometer"],
        // createdBy: createdByValues.map[json["createdBy"]]!,
        // createdOn: json["createdOn"],
        // // domain: clientIdValues.map[json["domain"]]!,
        // runhours: json["runhours"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "description": description,
        "partReference": partReference,
        "unitCost": unitCost,
        // "unit": unitValues.reverse[unit],
        // "status": statusValues.reverse[status],
        "types": types == null
            ? []
            : List<dynamic>.from(types!.map((x) => x.toJson())),
        "odometer": odometer,
        "createdBy": createdByValues.reverse[createdBy],
        "createdOn": createdOn,
        // "domain": clientIdValues.reverse[domain],
        "runhours": runhours,
      };
}

enum Unit { EMPTY, PIECE }

final unitValues = EnumValues({"": Unit.EMPTY, "Piece": Unit.PIECE});

enum ServiceStatus { OVERDUE, REGISTERED }

final serviceStatusValues = EnumValues(
    {"OVERDUE": ServiceStatus.OVERDUE, "REGISTERED": ServiceStatus.REGISTERED});

class TaggedService {
  TaggedService({
    this.identifier,
    this.taggedRegistries,
    this.tagged,
  });

  String? identifier;
  List<TaggedRegistry>? taggedRegistries;
  String? tagged;

  factory TaggedService.fromJson(Map<String, dynamic> json) => TaggedService(
        identifier: json["identifier"],
        taggedRegistries: json["taggedRegistries"] == null
            ? []
            : List<TaggedRegistry>.from(json["taggedRegistries"]!
                .map((x) => TaggedRegistry.fromJson(x))),
        tagged: json["tagged"],
      );

  // Map<String, dynamic> toJson() => {
  //       "identifier": identifier,
  //       "taggedRegistries": taggedRegistries == null
  //           ? []
  //           // : List<dynamic>.from(taggedRegistries!.map((x) => x.toJson())),
  //       "tagged": tagged,
  //     };
}

class TaggedRegistry {
  TaggedRegistry({
    this.identifier,
    this.dueDate,
    this.name,
    this.nextServiceRunHours,
    this.proposedServiceTime,
    this.serviceStatus,
    this.triggeredReason,
    this.cyclicCount,
    // this.domain,
  });

  String? identifier;
  num? dueDate;
  String? name;
  num? nextServiceRunHours;
  num? proposedServiceTime;
  ServiceStatus? serviceStatus;
  String? triggeredReason;
  num? cyclicCount;
  // ClientId? domain;

  factory TaggedRegistry.fromJson(Map<String, dynamic> json) => TaggedRegistry(
        identifier: json["identifier"],
        dueDate: json["dueDate"],
        name: json["name"],
        nextServiceRunHours: json["nextServiceRunHours"],
        proposedServiceTime: json["proposedServiceTime"],
        // serviceStatus: serviceStatusValues.map[json["serviceStatus"]]!,
        triggeredReason: json["triggeredReason"],
        cyclicCount: json["cyclicCount"],
        // domain: clientIdValues.map[json["domain"]]!,
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "dueDate": dueDate,
        "name": name,
        "nextServiceRunHours": nextServiceRunHours,
        "proposedServiceTime": proposedServiceTime,
        "serviceStatus": serviceStatusValues.reverse[serviceStatus],
        "triggeredReason": triggeredReason,
        "cyclicCount": cyclicCount,
        // "domain": clientIdValues.reverse[domain],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

Map<String, dynamic> listPendingServiceLogsData = {
  "listPendingServiceLogs": {
    "items": [
      {
        "service": {
          "identifier": "2fd478e7-95b0-48f9-836f-6d191b4f2a2c",
          "domain": "gge",
          "dueDate": 1702947613691,
          "name": "2000 Hours Coolant Change Service - Lonking CDM856",
          "nextServiceRunHours": 9299,
          "proposedServiceTime": 1715472000000,
          "serviceStatus": "OVERDUE",
          "cyclicCount": 3,
          "jobId": 68464,
          "jobNumber": "GGE:18415",
          "checklist": [
            {
              "identifier": "cb4c1929-f555-4637-a735-b17be1edcbe8",
              "name": "Coolant Change",
              "description": "Coolant Change",
              "criticality": "HIGH",
              "status": "ACTIVE",
              "createdBy": "riyas@nectarit",
              "createdOn": 1666344578000,
              "domain": "gge"
            },
            {
              "identifier": "23f67ad0-d540-4051-b8f0-4b95806b1552",
              "name": "Coolant Filter Change",
              "description": "Coolant Filter Change",
              "criticality": "MEDIUM",
              "status": "ACTIVE",
              "createdBy": "riyas@nectarit",
              "createdOn": 1666344602000,
              "domain": "gge"
            },
            {
              "identifier": "5704ee70-f2cb-487a-afc8-1f9a9c9b0d10",
              "name": "Distilled Water",
              "description": "Distilled Water",
              "criticality": "LOW",
              "status": "ACTIVE",
              "createdBy": "support@gge",
              "createdOn": 1680686864000,
              "domain": "gge"
            }
          ],
          "parts": [
            {
              "identifier": "5fdb3753-9452-4475-be26-20672439f99e",
              "part": {
                "identifier": "eb37d984-f654-4128-94f0-b93240362c0d",
                "name": "Coolant",
                "description": "Coolant",
                "partReference": "BS6580/91602/Falcon",
                "unitCost": 0,
                "status": "ACTIVE",
                "runhours": 2000,
                "createdBy": "techsupport@gge",
                "createdOn": 1672334779000,
                "domain": "gge"
              },
              "quantity": 50
            }
          ]
        },
        "asset": {
          "identifier": "790b1363-bdd8-4cc2-9368-4aa1de7e6bd5",
          "type": {
            "name": "LonkingWheelLoaderCDM856",
            "templateName": "Lonking Wheel Loader CDM856",
            "parentName": "Wheel Loader",
            "status": "ACTIVE"
          },
          "displayName": "WL003",
          "make": "Lonking",
          "model": "CDM856",
          "status": "ACTIVE",
          "spaces": [],
          "operationSchedules": [],
          "domain": "gge",
          "domainName": "GERMAN GULF ENTERPRISES LTD",
          "clientId": "alsafa",
          "clientName": "Al Safa"
        }
      },
      {
        "service": {
          "identifier": "14a8b707-49d4-4f5f-8f2a-f9288c0e2d0d",
          "domain": "gge",
          "dueDate": 1702947618771,
          "name": "4000 Hours Hydraulic oil Change Service - Lonking CDM856",
          "nextServiceRunHours": 8852,
          "proposedServiceTime": 1709078400000,
          "serviceStatus": "OVERDUE",
          "cyclicCount": 1,
          "jobId": 68478,
          "jobNumber": "GGE:18417",
          "checklist": [
            {
              "identifier": "c9f1277b-f977-4ef2-afac-de6e36afe901",
              "name": "All Pilot Filters",
              "description": "All Pilot Filters",
              "criticality": "LOW",
              "status": "ACTIVE",
              "createdBy": "support@gge",
              "createdOn": 1680688092000,
              "domain": "gge"
            },
            {
              "identifier": "17664336-8103-4e8a-ad9c-4f63408f617a",
              "name": "Hydraulic Oil Change",
              "description": "Hydraulic Oil Change",
              "criticality": "HIGH",
              "status": "ACTIVE",
              "createdBy": "riyas@nectarit",
              "createdOn": 1666344578000,
              "domain": "gge"
            },
            {
              "identifier": "85215731-ce5a-4a4f-902f-5347fef57e7f",
              "name": "All Hydraulic Filters",
              "description": "All Hydraulic Filters",
              "criticality": "LOW",
              "status": "ACTIVE",
              "createdBy": "support@gge",
              "createdOn": 1680688075000,
              "domain": "gge"
            }
          ],
          "parts": [
            {
              "identifier": "861da326-7405-41a7-a537-40b63eb2d7d0",
              "part": {
                "identifier": "d29c31b7-65ee-4696-82ea-f7fcc5e929cc",
                "name": "Hydraulic Oil",
                "description": "Hydraulic Oil",
                "partReference": "VG68 [Hyd.Oil]",
                "unit": "Litres",
                "status": "ACTIVE",
                "types": [
                  {
                    "type": "DoosanExcavatorDX140W",
                    "templateName": "Doosan Excavator DX140W",
                    "exclusive": true
                  },
                  {
                    "type": "LonkingWheelLoaderCDM856",
                    "templateName": "Lonking Wheel Loader CDM856",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawlerR330LC9S",
                    "templateName": "Hyundai Excavator Crawler R330LC-9S",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawlerR520LC9SLR",
                    "templateName": "Hyundai Excavator Crawler R520LC-9SLR",
                    "exclusive": true
                  },
                  {
                    "type": "DoosanWheelLoaderSD380",
                    "templateName": "Doosan Wheel Loader SD380",
                    "exclusive": true
                  },
                  {
                    "type": "LonkingExcavatorCrawlerCDM6365H",
                    "templateName": "Lonking Excavator Crawler CDM6365H",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawlerR220LC9SH",
                    "templateName": "Hyundai Excavator Crawler R220LC-9SH",
                    "exclusive": true
                  },
                  {
                    "type": "LonkingWheelLoaderCDM856",
                    "templateName": "Lonking Wheel Loader CDM856",
                    "exclusive": true
                  },
                  {
                    "type": "DoosanExcavatorDX420LCAK",
                    "templateName": "Doosan Excavator DX420LCA-K",
                    "exclusive": true
                  },
                  {
                    "type": "DoosanExcavatorS500LCV",
                    "templateName": "Doosan Excavator S500LC-V",
                    "exclusive": true
                  },
                  {
                    "type": "DoosanExcavatorCrawlerDX35Z",
                    "templateName": "Doosan Excavator Crawler DX35Z",
                    "exclusive": true
                  },
                  {
                    "type": "LeeBoyBackhoeLoaderXXX",
                    "templateName": "LeeBoy Backhoe Loader XXX",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawler290LC7A",
                    "templateName": "Hyundai Excavator Crawler 290LC-7A",
                    "exclusive": true
                  },
                  {
                    "type": "DoosanWheelLoaderDL420A",
                    "templateName": "Doosan Wheel Loader DL420A",
                    "exclusive": true
                  },
                  {
                    "type": "LonkingExcavatorCrawlerCDM6225",
                    "templateName": "Lonking Excavator Crawler CDM6225",
                    "exclusive": true
                  },
                  {
                    "type": "LonkingExcatorCrawlerR450LC7",
                    "templateName": "Lonking Excator Crawler R450LC-7",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorWheeledR140W9S",
                    "templateName": "HyundaiExcavator Wheeled R140W-9S",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawlerR160LC9S",
                    "templateName": "Hyundai Excavator Crawler R160LC-9S",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawler480LC9S",
                    "templateName": "Hyundai Excavator Crawler 480LC-9S",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawlerR300LC7",
                    "templateName": "Hyundai Excavator Crawler R300LC-7",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawler300LC9SH",
                    "templateName": "Hyundai Excavator Crawler 300LC-9SH",
                    "exclusive": true
                  },
                  {
                    "type": "HyundaiExcavatorCrawlerR500LC7",
                    "templateName": "Hyundai Excavator Crawler R500LC-7",
                    "exclusive": true
                  }
                ],
                "runhours": 4000,
                "createdBy": "riyas@nectarit",
                "createdOn": 1666347465000,
                "domain": "gge"
              },
              "quantity": 210
            }
          ]
        },
        "asset": {
          "identifier": "790b1363-bdd8-4cc2-9368-4aa1de7e6bd5",
          "type": {
            "name": "LonkingWheelLoaderCDM856",
            "templateName": "Lonking Wheel Loader CDM856",
            "parentName": "Wheel Loader",
            "status": "ACTIVE"
          },
          "displayName": "WL003",
          "make": "Lonking",
          "model": "CDM856",
          "status": "ACTIVE",
          "spaces": [],
          "operationSchedules": [],
          "domain": "gge",
          "domainName": "GERMAN GULF ENTERPRISES LTD",
          "clientId": "alsafa",
          "clientName": "Al Safa"
        }
      }
    ],
    "totalItems": 2,
    "totalPages": 1,
    "pageItemCount": 5,
    "currentPage": 0
  }
};
