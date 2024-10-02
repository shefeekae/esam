import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:secure_storage/services/shared_prefrences_services.dart';

class AssetsStatusServices {
  DateTime now = DateTime.now();

  List getAssetListCountTimeFilterPayload() {
    String? data = SharedPrefrencesServices().getData(key: "appTheme");

    if (data != null) {
      var jsonDecoded = jsonDecode(data);

      Map<String, dynamic>? map = jsonDecoded['assetCommunicationStatus'];

      Map<String, dynamic> lessCoummincating =
          getTimeFilterMap(map?['lessCommunicating'], "lessCommunicating");

      Map<String, dynamic> notCommunicating =
          getTimeFilterMap(map?['notCommunicating'], "notCommunicating");

      Map<String, dynamic> frequentlyCommunicating = getTimeFilterMap(
          map?['frequentlyCommunicating'], "frequentlyCommunicating");

      Map<String, dynamic> notConnected =
          getTimeFilterMap(map?['notConnected'], "notConnected");

      return [
        lessCoummincating,
        notCommunicating,
        frequentlyCommunicating,
        notConnected
      ];
    }
    return [];
  }

  Map<String, dynamic> getTimeFilterMap(Map<String, dynamic>? map, String key) {
    int start = map?['start'] ?? 0;
    int end = map?['end'] ?? 0;

    return {
      "startDate": start == 0
          ? 0
          : now.subtract(Duration(minutes: start)).millisecondsSinceEpoch,
      "endDate": end == 0
          ? 0
          : now.subtract(Duration(minutes: end)).millisecondsSinceEpoch,
      "key": key,
    };
  }

//  =======================================================================================
// Get Status List

  List<Map<String, dynamic>> getStatusListData(
    BuildContext context, {
    required Map<String, dynamic>? data,
  }) {
    int underMaintenance = data?['underMaintenance'] ?? 0;

    int lessCommunicating = data?['lessCommunicating'] ?? 0;
    int notConnected = data?['notConnected'] ?? 0;
    int frequentlyCommunicating = data?['frequentlyCommunicating'] ?? 0;
    int notCommunicating = data?['notCommunicating'] ?? 0;

    int connected =
        notCommunicating + lessCommunicating + frequentlyCommunicating;

    return [
      {
        "title": "Connected",
        "count": connected,
        "colors": [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).primaryColor
        ],
        "key": "CONNECTED",
      },
      {
        "title": "Not Connected",
        "count": notConnected,
        "colors": [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).primaryColor
        ],
        "key": "NOT_CONNECTED",
      },
      {
        "title": "Frequently Communicating",
        "count": frequentlyCommunicating,
        "colors": [Colors.green],
        "key": "COMMUNICATING",
      },
      {
        "title": "Less Communicating",
        "count": lessCommunicating,
        "colors": [Colors.amber],
        "textColor": Colors.black,
        "key": "LESS_COMMUNICATING",
      },
      {
        "title": "Non Communicating",
        "count": notCommunicating,
        "colors": [Colors.red],
        "key": "NON_COMMUNICATING",
      },
      {
        "title": "Under Maintenance",
        "count": underMaintenance,
        "colors": [
          Theme.of(context).colorScheme.secondaryContainer,
          Theme.of(context).primaryColor
        ],
        "key": "MAINTENANCE",
      },
    ];
  }

// ==================================================================================

  String convertToK(int number) {
    if (number >= 1000) {
      double result = number / 1000;
      if (result == result.toInt()) {
        return '${result.toInt()}k';
      } else {
        return '${result.toStringAsFixed(1)}k';
      }
    } else {
      return number.toString();
    }
  }

// ====================================================================

  Map<String, dynamic> updateTemplateKeys({
    required Map<String, dynamic> variables,
    required String templateKey,
    required String filterKey,
  }) {
    Map<String, dynamic> updatedMap = {};

    variables.forEach((key, value) {
      // Replace the old key with the new key
      String updatedKey = (key == templateKey) ? filterKey : key;
      updatedMap[updatedKey] = value;
    });

    return updatedMap;
  }
}
