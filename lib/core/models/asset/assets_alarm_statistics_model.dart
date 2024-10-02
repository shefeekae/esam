// To parse this JSON data, do
//
//     final assetAlarmStatisticsModel = assetAlarmStatisticsModelFromJson(jsonString);

import 'dart:convert';

AssetAlarmStatisticsModel assetAlarmStatisticsModelFromJson(String str) =>
    AssetAlarmStatisticsModel.fromJson(json.decode(str));

String assetAlarmStatisticsModelToJson(AssetAlarmStatisticsModel data) =>
    json.encode(data.toJson());

class AssetAlarmStatisticsModel {
  GetAssetAlarmsStatisticsData getAssetAlarmsStatisticsData;

  AssetAlarmStatisticsModel({
    required this.getAssetAlarmsStatisticsData,
  });

  factory AssetAlarmStatisticsModel.fromJson(Map<String, dynamic> json) =>
      AssetAlarmStatisticsModel(
        getAssetAlarmsStatisticsData: GetAssetAlarmsStatisticsData.fromJson(
            json["getAssetAlarmsStatisticsData"]),
      );

  Map<String, dynamic> toJson() => {
        "getAssetAlarmsStatisticsData": getAssetAlarmsStatisticsData.toJson(),
      };
}

class GetAssetAlarmsStatisticsData {
  String id;
  String domain;
  String name;
  String type;
  List<AlarmData> data;

  GetAssetAlarmsStatisticsData({
    required this.id,
    required this.domain,
    required this.name,
    required this.type,
    required this.data,
  });

  factory GetAssetAlarmsStatisticsData.fromJson(Map<String, dynamic> json) =>
      GetAssetAlarmsStatisticsData(
        id: json["id"],
        domain: json["domain"],
        name: json["name"],
        type: json["type"],
        data: List<AlarmData>.from(
            json["data"].map((x) => AlarmData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "domain": domain,
        "name": name,
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AlarmData {
  String key;
  int count;
  String label;
  String i18NLabel;
  FilterToSet filterToSet;

  AlarmData({
    required this.key,
    required this.count,
    required this.label,
    required this.i18NLabel,
    required this.filterToSet,
  });

  factory AlarmData.fromJson(Map<String, dynamic> json) => AlarmData(
        key: json["key"],
        count: json["count"],
        label: json["label"],
        i18NLabel: json["i18nLabel"],
        filterToSet: FilterToSet.fromJson(json["filterToSet"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "count": count,
        "label": label,
        "i18nLabel": i18NLabel,
        "filterToSet": filterToSet.toJson(),
      };
}

class FilterToSet {
  List<String> status;
  List<String>? criticality;
  List<String>? category;

  FilterToSet({
    required this.status,
    this.criticality,
    this.category,
  });

  factory FilterToSet.fromJson(Map<String, dynamic> json) => FilterToSet(
        status: List<String>.from(json["status"].map((x) => x)),
        criticality: json["criticality"] == null
            ? []
            : List<String>.from(json["criticality"]!.map((x) => x)),
        category: json["category"] == null
            ? []
            : List<String>.from(json["category"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": List<dynamic>.from(status.map((x) => x)),
        "criticality": criticality == null
            ? []
            : List<dynamic>.from(criticality!.map((x) => x)),
        "category":
            category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
      };
}

Map<String, dynamic> findAssetDAta = {
  "findAsset": {
    "asset": {
      "type": "HyundaiExcavatorCrawlerR330LC9S",
      "data": {
        "domain": "gge",
        "name": "EX207",
        "identifier": "b996b969-d8c2-42f7-8307-16bcae570f33",
        "make": "Hyundai",
        "model": "R330LC-9S",
        "displayName": "EX207",
        "sourceTagPath": null,
        "ddLink": "",
        "dddLink": null,
        "profileImage": "",
        "status": "ACTIVE",
        "createdOn": 1659963300176,
        "assetCode": null,
        "typeName": "Hyundai Excavator Crawler R330LC-9S",
        "ownerClientId": "khansaheb"
      }
    },
    "parent": "HeavyMachine",
    "assetLatest": {
      "name": "EX207",
      "clientName": "Khansaheb",
      "serialNumber": "002074",
      "dataTime": 1704865086000,
      "underMaintenance": false,
      "points": [
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": "ON",
          "pointName": "Engine Status",
          "pointId": "Engine Status",
          "dataType": "String",
          "displayName": "Engine Status",
          "type": "STRING",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09EngineStatus%3B%0A%09EngineStatus%3Dconvert%3AconvertToDecimal%28DIN1%29%3D%3D1%3F%27ON%27%3A%27OFF%27%3B%0A%09EngineStatus%3B%0A%7D"
        },
        {
          "unit": "kilometer per hour",
          "unitSymbol": "km/hr",
          "data": 2,
          "pointName": "Speed",
          "pointId": "Speed",
          "dataType": "Double",
          "displayName": "Speed",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7Bspeed%3Bspeed%3Dconvert%3AconvertToLong%28Speed%29%3Bspeed%7D"
        },
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": 13,
          "pointName": "Visible Satellites",
          "pointId": "Visible Satellites",
          "dataType": "Integer",
          "displayName": "Visible Satellites",
          "type": "INTEGER",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09gps%3B%0A%09gps%3Dconvert%3AconvertToLong%28VisibleSatellites%29%3B%0A%09gps%3B%0A%7D"
        },
        {
          "unit": "volt",
          "unitSymbol": "V",
          "data": 28.27,
          "pointName": "Vehicle Battery",
          "pointId": "Vehicle Battery",
          "dataType": "Double",
          "displayName": "Vehicle Battery",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09vehBat%3B%0A%09vehBat%3Dconvert%3AconvertToLong%28ExternalPowerVoltage%29%2F1000.00%3B%0A%09vehBat%3Dnumber%3AformatDouble%28vehBat%2C2%29%3B%0A%09vehBat%3B%0A%7D"
        },
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": "Disengaged",
          "pointName": "Safety Lock",
          "pointId": "Safety Lock",
          "dataType": "String",
          "displayName": "Safety Lock",
          "type": "STRING",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20%27Engaged%27%3B%0Aconvert%3AconvertToDecimal%28DIN2%29%3D%3D0%3F%27Disengaged%27%3A%27Engaged%27%3B%7D"
        },
        {
          "unit": "kilometer",
          "unitSymbol": "km",
          "data": 21,
          "pointName": "Altitude",
          "pointId": "Altitude",
          "dataType": "Double",
          "displayName": "Altitude",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09altitude%3B%0A%09altitude%3Dconvert%3AconvertToDecimal%28Altitude%29%3B%0A%09altitude%3D%28altitude%20%2B%20math%3Apow%282%2C%2015%29%29%20%25%20math%3Apow%282%2C%2016%29%3B%0A%09altitude%20%3D%20altitude%20-%20math%3Apow%282%2C%2015%29%3B%0A%09altitude%3Dnumber%3AformatDouble%28altitude%2C2%29%3B%0A%09altitude%3B%0A%7D"
        },
        {
          "unit": "steradian",
          "unitSymbol": "sr",
          "data": 86,
          "pointName": "Angle",
          "pointId": "Angle",
          "dataType": "Double",
          "displayName": "Angle",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09angle%3B%0A%09angle%3Dconvert%3AconvertToLong%28Angle%29%3B%0A%09angle%3B%0A%7D"
        },
        {
          "unit": "volt",
          "unitSymbol": "V",
          "data": 3.94,
          "pointName": "Device Battery",
          "pointId": "Device Battery",
          "dataType": "Double",
          "displayName": "Device Battery",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09deviceBattery%3B%0A%09deviceBattery%3Dconvert%3AconvertToLong%28InternalBatteryVoltage%29%2F1000.00%3B%0A%09deviceBattery%3Dnumber%3AformatDouble%28deviceBattery%2C2%29%3B%0A%09deviceBattery%3B%0A%7D"
        },
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": 5,
          "pointName": "GSM Signal",
          "pointId": "GSM Signal",
          "dataType": "Integer",
          "displayName": "GSM Signal",
          "type": "INTEGER",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "1",
          "expression":
              "%24%7B%0A%09gsm%3B%0A%09gsm%3Dconvert%3AconvertToLong%28GSMSignal%29%3B%0A%09gsm%3B%0A%7D"
        },
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": {"latitude": 25.031744, "longitude": 55.11893},
          "pointName": "Location",
          "pointId": "Location",
          "dataType": "Geopoint",
          "displayName": "Location",
          "type": "GEOPOINT",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "2",
          "expression":
              "%24%7B%0Alocation%3D%5B%5D%3B%0Alat%3BlatData%3B%0Alng%3BlngData%3B%0Alat%3Dconvert%3AconvertToBinary%28Latitude.substring%280%2C2%29%29%3B%0Alat%3Dlat.substring%280%2C1%29%3B%0Aif%28lat%20eq%201%29%20%0AlatData%20%3D%20convert%3AgetTwosComplement%28Latitude%29%2F10000000.00%3B%0Aelse%20%0AlatData%20%3Dconvert%3AconvertToLong%28Latitude%29%2F10000000.00%3B%0A%0Alng%3Dconvert%3AconvertToBinary%28Longitude.substring%280%2C2%29%29%3B%0Alng%3Dlng.substring%280%2C1%29%3B%0Aif%28lng%20eq%201%29%20%0AlngData%20%3D%20convert%3AgetTwosComplement%28Longitude%29%2F10000000.00%3B%0Aelse%20%0AlngData%20%3Dconvert%3AconvertToLong%28Longitude%29%2F10000000.00%3B%0A%0Alocation%3D%5BlatData%2ClngData%5D%3B%0Alocation%3B%0A%7D"
        },
        {
          "unit": "liter",
          "unitSymbol": "L",
          "data": 425.7079884582589,
          "pointName": "Fuel Level",
          "pointId": "Fuel Level",
          "dataType": "Double",
          "displayName": "Fuel Level",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "2",
          "expression":
              "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%20fl%20%3D%20convert%3AconvertToDecimal%28DallasTemperature5%29%3B%20if%28fl%20%3E2813%20%7C%7C%20fl%20%3C%20329%29%20return%20null%3B%20flf%3D517%20%2B%20-0.19%2afl%20%2B%201.82E-04%2amath%3Apow%28fl%2C2%29%20%2B%20-1.16E-07%2amath%3Apow%28fl%2C3%29%20%2B%201.89E-11%2amath%3Apow%28fl%2C4%29%3B%20if%28flf%20%3C%200%29%20return%200.0%3B%20if%28flf%20%3E%20480%29%20return%20480.00%3B%20return%20flf%3B%7D"
        },
        {
          "unit": "metre",
          "unitSymbol": "m",
          "data": 0,
          "pointName": "Distance Travelled",
          "pointId": "Distance Travelled",
          "dataType": "Double",
          "displayName": "Distance Travelled",
          "type": "DOUBLE",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "2",
          "expression":
              "%24%7Bvir_odo%3B%0Aif%28TripOdometer%3D%3Dnull%29%20return%20number%3AreturnNaN%28%29%3B%0Avir_odo%3Dconvert%3AconvertToDecimal%28TripOdometer%29%3B%0Avir_odo%3B%0A%7D"
        },
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": "E",
          "pointName": "Direction",
          "pointId": "Direction",
          "dataType": "String",
          "displayName": "Direction",
          "type": "STRING",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "2",
          "expression":
              "%24%7B%0A%20%20%20%20%20%20%20%20direction%3Bangle%3B%0A%20%20%20%20%20%20%20%20angle%3DAngle%3B%0A%20%0A%20%20%20%20%20%20%20if%28angle%20ge%20337.5%20or%20angle%20lt%2022.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27N%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2022.5%20and%20angle%20lt%2067.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NE%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2067.5%20%20and%20angle%20lt%20112.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27E%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20112.5%20and%20angle%20lt%20157.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SE%27%3B%20%20%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20157.5%20and%20angle%20lt%20202.5%29%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27S%27%3B%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20202.5%20and%20angle%20lt%20247.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SW%27%3B%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20247.5%20and%20angle%20lt%20292.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27W%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20292.5%20and%20angle%20lt%20337.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NW%27%3B%0A%20%0A%20%20%20%20%20%20%20direction%3B%0A%7D"
        },
        {
          "unit": "unitless",
          "unitSymbol": "-",
          "data": "On",
          "pointName": "Motion Status",
          "pointId": "Motion Status",
          "dataType": "String",
          "displayName": "Motion Status",
          "type": "STRING",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "3",
          "expression":
              "%24%7B%0Aif%28EngineStatus%20eq%20%27OFF%27%29%20return%20%27Off%27%3B%0Aif%28EngineStatus%20eq%20%27ON%27%20%26%26%20SafetyLock%20eq%20%27Disengaged%27%29%20return%20%27On%27%0Aif%28EngineStatus%20eq%20%27ON%27%29%20return%20%27Idle%27%3B%0A%7D"
        },
        {
          "unit": "percent",
          "unitSymbol": "%",
          "data": 88.68916,
          "pointName": "Fuel Remaining",
          "pointId": "Fuel Remaining",
          "dataType": "Float",
          "displayName": "Fuel Remaining",
          "type": "FLOAT",
          "status": "healthy",
          "pointAccessType": "READONLY",
          "precedence": "3",
          "expression":
              "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%20if%28FuelLevel%20%3E%20480%20%7C%7C%20FuelLevel%20%3C%200%29%20return%20null%3B%20return%20%28FuelLevel%2F480%29%2a100%3B%7D"
        }
      ],
      "operationStatus": "On",
      "path": [
        {
          "name": "Khansaheb",
          "entity": {
            "type": "Customer",
            "data": {
              "identifier": "khansaheb",
              "domain": "ggesharjah",
              "name": "Khansaheb",
              "parentType": "Community"
            },
            "identifier": "khansaheb",
            "domain": "ggesharjah"
          }
        },
        {
          "name": "EX207",
          "entity": {
            "type": "HyundaiExcavatorCrawlerR330LC9S",
            "data": {
              "identifier": "b996b969-d8c2-42f7-8307-16bcae570f33",
              "domain": "gge",
              "name": "EX207",
              "parentType": "Equipment"
            },
            "identifier": "b996b969-d8c2-42f7-8307-16bcae570f33",
            "domain": "gge"
          }
        }
      ],
      "location": "POINT(55.1189316 25.0317433)"
    },
    "criticalPoints": [
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "4468ea58-f960-485e-83e5-002d49c560ca",
          "expression":
              "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%20if%28FuelLevel%20%3E%20480%20%7C%7C%20FuelLevel%20%3C%200%29%20return%20null%3B%20return%20%28FuelLevel%2F480%29%2a100%3B%7D",
          "physicalQuantity": "percentage",
          "pointName": "Fuel Remaining",
          "maxValue": "",
          "displayName": "Fuel Remaining",
          "dataType": "Float",
          "typeName": "Config Point",
          "pid": 45,
          "remoteDataType": "",
          "type": "",
          "createdOn": "1655213905871",
          "precedence": "3",
          "accessType": "READONLY",
          "unit": "percent",
          "minValue": "",
          "pointId": "Fuel Remaining",
          "createdBy": "support@gge",
          "domain": "nectarit",
          "unitSymbol": "%",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "fee560b9-2515-4097-9bca-f4dac68965f8",
          "expression":
              "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20%27Engaged%27%3B%0Aconvert%3AconvertToDecimal%28DIN2%29%3D%3D0%3F%27Disengaged%27%3A%27Engaged%27%3B%7D",
          "physicalQuantity": "status string",
          "pointName": "Safety Lock",
          "maxValue": "",
          "displayName": "Safety Lock",
          "dataType": "String",
          "typeName": "Config Point",
          "pid": 242,
          "type": "String",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "unitless",
          "minValue": "",
          "pointId": "Safety Lock",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "-",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "41bce8f4-2ac6-4ef7-b3cf-69380b96fb25",
          "expression":
              "%24%7B%0Aif%28EngineStatus%20eq%20%27OFF%27%29%20return%20%27Off%27%3B%0Aif%28EngineStatus%20eq%20%27ON%27%20%26%26%20SafetyLock%20eq%20%27Disengaged%27%29%20return%20%27On%27%0Aif%28EngineStatus%20eq%20%27ON%27%29%20return%20%27Idle%27%3B%0A%7D",
          "physicalQuantity": "status string",
          "pointName": "Motion Status",
          "maxValue": "",
          "displayName": "Motion Status",
          "dataType": "String",
          "typeName": "Config Point",
          "pid": 12,
          "type": "String",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "3",
          "accessType": "READONLY",
          "unit": "unitless",
          "minValue": "",
          "pointId": "Motion Status",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "-",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "d170f80f-aeb5-4d17-ac91-7f770c0b9125",
          "expression":
              "%24%7Bif%28EngineStatus%20eq%20%27OFF%27%29%20return%20null%3B%20fl%20%3D%20convert%3AconvertToDecimal%28DallasTemperature5%29%3B%20if%28fl%20%3E2813%20%7C%7C%20fl%20%3C%20329%29%20return%20null%3B%20flf%3D517%20%2B%20-0.19%2afl%20%2B%201.82E-04%2amath%3Apow%28fl%2C2%29%20%2B%20-1.16E-07%2amath%3Apow%28fl%2C3%29%20%2B%201.89E-11%2amath%3Apow%28fl%2C4%29%3B%20if%28flf%20%3C%200%29%20return%200.0%3B%20if%28flf%20%3E%20480%29%20return%20480.00%3B%20return%20flf%3B%7D",
          "physicalQuantity": "volume",
          "pointName": "Fuel Level",
          "maxValue": "",
          "displayName": "Fuel Level",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 21,
          "remoteDataType": "",
          "type": "",
          "createdOn": "1655213876398",
          "precedence": "2",
          "accessType": "READONLY",
          "unit": "liter",
          "minValue": "",
          "pointId": "Fuel Level",
          "createdBy": "support@gge",
          "domain": "nectarit",
          "unitSymbol": "L",
          "status": "ACTIVE"
        }
      }
    ],
    "lowPriorityPoints": [
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "7770df6f-f824-4545-a3a3-60761b364243",
          "expression":
              "%24%7Bvir_odo%3B%0Aif%28TripOdometer%3D%3Dnull%29%20return%20number%3AreturnNaN%28%29%3B%0Avir_odo%3Dconvert%3AconvertToDecimal%28TripOdometer%29%3B%0Avir_odo%3B%0A%7D",
          "physicalQuantity": "length",
          "pointName": "Distance Travelled",
          "maxValue": "",
          "displayName": "Distance Travelled",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 31,
          "type": "Double",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "2",
          "accessType": "READONLY",
          "unit": "metre",
          "minValue": "",
          "pointId": "Distance Travelled",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "m",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "3bfe5dce-2550-4d00-921d-c88506a2c832",
          "expression":
              "%24%7B%0A%09gsm%3B%0A%09gsm%3Dconvert%3AconvertToLong%28GSMSignal%29%3B%0A%09gsm%3B%0A%7D",
          "physicalQuantity": "status integer",
          "pointName": "GSM Signal",
          "maxValue": "",
          "displayName": "GSM Signal",
          "dataType": "Integer",
          "typeName": "Config Point",
          "pid": 20,
          "type": "Integer",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "unitless",
          "minValue": "",
          "pointId": "GSM Signal",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "-",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "898e64f8-43ca-42e3-91ab-00a46eacb76f",
          "expression":
              "%24%7Bconvert%3AconvertToDecimal%28DallasTemperature5%29%7D",
          "physicalQuantity": "electric potential",
          "pointName": "Fuel Data",
          "maxValue": "",
          "displayName": "Fuel Data",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 46,
          "remoteDataType": "",
          "type": "",
          "createdOn": "1655213845040",
          "precedence": "2",
          "accessType": "READONLY",
          "unit": "millivolt",
          "minValue": "",
          "pointId": "Fuel Data",
          "createdBy": "support@gge",
          "domain": "nectarit",
          "unitSymbol": "mV",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "8688c740-4395-45c0-a662-5367985cdbbc",
          "expression":
              "%24%7Bspeed%3Bspeed%3Dconvert%3AconvertToLong%28Speed%29%3Bspeed%7D",
          "physicalQuantity": "velocity",
          "pointName": "Speed",
          "maxValue": "",
          "displayName": "Speed",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 5,
          "type": "Double",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "kilometer per hour",
          "minValue": "",
          "pointId": "Speed",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "km/hr",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "6148688d-e5e2-40b1-a9db-afd77f433344",
          "expression":
              "%24%7B%0A%20%20%20%20%20%20%20%20direction%3Bangle%3B%0A%20%20%20%20%20%20%20%20angle%3DAngle%3B%0A%20%0A%20%20%20%20%20%20%20if%28angle%20ge%20337.5%20or%20angle%20lt%2022.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27N%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2022.5%20and%20angle%20lt%2067.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NE%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%2067.5%20%20and%20angle%20lt%20112.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27E%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20112.5%20and%20angle%20lt%20157.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SE%27%3B%20%20%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20157.5%20and%20angle%20lt%20202.5%29%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27S%27%3B%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20202.5%20and%20angle%20lt%20247.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27SW%27%3B%20%20%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20247.5%20and%20angle%20lt%20292.5%29%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27W%27%3B%0A%0A%20%20%20%20%20%20%20else%20if%28angle%20ge%20292.5%20and%20angle%20lt%20337.5%29%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20direction%3D%27NW%27%3B%0A%20%0A%20%20%20%20%20%20%20direction%3B%0A%7D",
          "physicalQuantity": "status string",
          "pointName": "Direction",
          "maxValue": "",
          "displayName": "Direction",
          "dataType": "String",
          "typeName": "Config Point",
          "pid": 30,
          "type": "String",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "2",
          "accessType": "READONLY",
          "unit": "unitless",
          "minValue": "",
          "pointId": "Direction",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "-",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "7e03df88-56bc-4430-82af-5eda5213d0e2",
          "expression":
              "%24%7B%0A%09angle%3B%0A%09angle%3Dconvert%3AconvertToLong%28Angle%29%3B%0A%09angle%3B%0A%7D",
          "physicalQuantity": "solid angle",
          "pointName": "Angle",
          "maxValue": "",
          "displayName": "Angle",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 26,
          "type": "Double",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "steradian",
          "minValue": "",
          "pointId": "Angle",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "sr",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "ad9ff1e4-9aa4-4a6a-a345-ab747adbdca6",
          "expression":
              "%24%7B%0A%09gps%3B%0A%09gps%3Dconvert%3AconvertToLong%28VisibleSatellites%29%3B%0A%09gps%3B%0A%7D",
          "physicalQuantity": "status integer",
          "pointName": "Visible Satellites",
          "maxValue": "",
          "displayName": "Visible Satellites",
          "dataType": "Integer",
          "typeName": "Config Point",
          "pid": 1,
          "type": "Integer",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "unitless",
          "minValue": "",
          "pointId": "Visible Satellites",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "-",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "199376eb-5152-4db9-acc4-257f49365dcc",
          "expression":
              "%24%7B%0A%09deviceBattery%3B%0A%09deviceBattery%3Dconvert%3AconvertToLong%28InternalBatteryVoltage%29%2F1000.00%3B%0A%09deviceBattery%3Dnumber%3AformatDouble%28deviceBattery%2C2%29%3B%0A%09deviceBattery%3B%0A%7D",
          "physicalQuantity": "electric potential",
          "pointName": "Device Battery",
          "maxValue": "",
          "displayName": "Device Battery",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 29,
          "type": "Double",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "volt",
          "minValue": "",
          "pointId": "Device Battery",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "V",
          "status": "ACTIVE"
        }
      },
      {
        "type": "ConfigPoint",
        "data": {
          "possibleValues": "",
          "identifier": "744a6fa7-6e22-4d2d-9ef9-10ae43d73831",
          "expression":
              "%24%7B%0A%09altitude%3B%0A%09altitude%3Dconvert%3AconvertToDecimal%28Altitude%29%3B%0A%09altitude%3D%28altitude%20%2B%20math%3Apow%282%2C%2015%29%29%20%25%20math%3Apow%282%2C%2016%29%3B%0A%09altitude%20%3D%20altitude%20-%20math%3Apow%282%2C%2015%29%3B%0A%09altitude%3Dnumber%3AformatDouble%28altitude%2C2%29%3B%0A%09altitude%3B%0A%7D",
          "physicalQuantity": "length",
          "pointName": "Altitude",
          "maxValue": "",
          "displayName": "Altitude",
          "dataType": "Double",
          "typeName": "Config Point",
          "pid": 24,
          "type": "Double",
          "remoteDataType": "",
          "createdOn": "1653321603310",
          "precedence": "1",
          "accessType": "READONLY",
          "unit": "kilometer",
          "minValue": "",
          "pointId": "Altitude",
          "createdBy": "riyas@nectarit",
          "domain": "nectarit",
          "unitSymbol": "km",
          "status": "ACTIVE"
        }
      }
    ],
    "settings": {
      "identifier": "a40aca90-3053-4256-b84e-cde4a285d5d3",
      "effectiveRunHours": 18996.061401388888,
      "odometer": 379.0299999999999,
      "odometerDailyAvg": 1.0114285714285713,
      "runhours": 19280.245406111117,
      "runhoursDailyAvg": 6.91702007936508,
      "runhoursKey": "runhours",
      "fuelkey": "NULL",
      "location": "Fujairah",
      "totalFuelUsed": 8951.216730036393,
      "updateTime": 1704671999999,
      "status": "ACTIVE"
    },
    "device": {
      "type": "Device",
      "data": {
        "sourceId": "866907057447665",
        "deviceIp": "",
        "configuration": "",
        "latitude": "",
        "typeName": "Device",
        "slot": "",
        "deviceName": "866907057447665",
        "createdOn": "1659964746952",
        "protocol": "FMB640",
        "password": "spacePwd",
        "model": "FMS",
        "datasourceName": "866907057447665",
        "make": "Teltonika",
        "longitude": "",
        "allocated": "false",
        "deviceType": "Telematics",
        "identifier": "a7933e79-fb6f-4b65-8c9e-5e57013a7a47",
        "serialNumber": "866907057447665",
        "writebackPort": "",
        "timeZone": "",
        "userName": "usertrimtest",
        "priority": "",
        "version": "V0.07_8",
        "url": "",
        "tags": "",
        "createdBy": "support@gge",
        "publish": "true",
        "domain": "gge",
        "devicePort": "8008",
        "networkProtocol": "TCP",
        "status": "ACTIVE"
      }
    },
    "sim": null
  }
};
