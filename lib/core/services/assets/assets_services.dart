
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nectar_assets/core/models/asset/asset_info_model.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/models/asset/assets_parts_model.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/schemas/documents_schemas.dart';
import 'package:nectar_assets/core/schemas/services_shemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/equipment_details.dart';
import 'package:secure_storage/secure_storage.dart';
import '../../models/getutilizationdata_model.dart';
import '../../models/service_logs_model.dart';
import '../encryption_decryption_services.dart';


class AssetsServices {
//  ========================================================================================
//  payload of getasset list.

  static UserDataSingleton userData = UserDataSingleton();

  Map<String, dynamic> getAssetListVariables = {
    "filter": {
      "domain": userData.domain,
    }
  };

  String getPath({required List list}) {
    String sourceTagPath = "";

    for (var index = 0; index < list.length; index++) {
      String name = list[index]['name'];
      sourceTagPath = index == 0 ? name : "$sourceTagPath  -  $name";
    }
    return sourceTagPath;
  }

  // ===================

  String getAssetDashboardQuery(String key) {
    if (key == 'documents') {
      return DocumentSchema.getDocumentListQuery;
    } else if (key == "parts") {
      return AssetSchema.assetsPartsLiveQuery;
    } else if (key == "services") {
      return ServiceSchema.listPendingServiceLogs;
    } else if (key == "dailyhours") {
      return AssetSchema.getUtilizationData;
    }

    return "";
  }

  // ============================================================================
  // get dashboard data;

  String getDashboardData(String key, Map<String, dynamic> result) {
    if (key == "documents") {
      DocumentListModel documentsModel = DocumentListModel.fromJson(result);
      return documentsModel.getDocumentsList!.totalDocumentCount.toString();
    } else if (key == "parts") {
      AssetPartsModel assetPartsModel = assetPartsModelFromJson(result);

      return assetPartsModel.assetPartsLive!.totalItems.toString();
    } else if (key == "services") {
      LogsServiceModel logsServiceModel = logsServiceModelFromJson(result);

      return logsServiceModel.listPendingServiceLogs!.totalItems.toString();
    } else if (key == "dailyhours") {
      Map getUtilizationData = result['getUtilizationData'];

      if (getUtilizationData.isEmpty) {
        return "0";
      }

      num? dailyHours = getUtilizationData['dailyAverage'];

      String data = dailyHours == null
          ? "N/A"
          : AssetsServices().convertDuration(
              Duration(
                milliseconds: dailyHours.toInt(),
              ),
            );
      return data;
    }

    return "N/A";
  }

  // ======================================================================================
  // Get utilization data variable

  Map<String, dynamic> getVariables({
    required Map<String, dynamic> asset,
    required String key,
  }) {
   

    if (key == "documents") {
      return {
        "data": {
          "domain": userData.domain,
          "assets": [asset],
          "pageSize": 1,
          "offset": 1,
          "name": "",
        }
      };
    } else if (key == "parts") {
      return {
        "queryParam": {"page": 1, "size": 1, "sort": ""},
        "body": {
          "identifier": asset['data']['identifier'],
          // "displayName": "coo"
        }
      };
    } else if (key == "services") {
      return {
        "data": <String, dynamic>{
          "domain": userData.domain,
          "assets": [asset],
          "dateRange": null,
          "serviceName": "",
          "states": ["REGISTERED"],
        },
        "queryParam": {
          "page": 0,
          "size": 1,
          "sort": "service.proposedServiceTime,ASC",
        },
      };
    } else if (key == "dailyhours") {
      DateTime now = DateTime.now();

      DateTime last7days = now.subtract(const Duration(days: 7));

      return {
        "payload": {
          "startDate": last7days.millisecondsSinceEpoch,
          "endDate": now.millisecondsSinceEpoch,
          "domain": userData.domain,
          "assets": [
            asset,
          ]
        }
      };
    }

    return {};
  }

  Color getOperationStatusColor({required String operationStatus}) {
    switch (operationStatus) {
      case "On":
        return Colors.green;

      case "Off":
        return Colors.red;

      case "Idle":
        return Colors.yellow;

      default:
        return Colors.orange;
    }
  }

// ============================================================
// Parse the wkt point

  LatLng? parseWktPoint(String wktPoint) {
    try {
      List<String> coords =
          wktPoint.replaceAll('POINT(', '').replaceAll(')', '').split(' ');
      double lng = double.parse(coords[0]);
      double lat = double.parse(coords[1]);
      return LatLng(lat, lng);
    } catch (e) {
      return null;
      // TODO
    }
  }

// =============================================================
// get assset status colors

  Color getStatusColors(String key) {
    switch (key) {
      case "On":
        return Colors.green;

      case "Off":
        return Colors.red;

      case "Idle":
        return Colors.yellow;

      default:
        return Colors.black;
    }
  }

// ===============================================================
// Get asset dashboard comparing data.

  Future<List<Map>?> getAssetDashboardComparingData({
    required Map<String, dynamic> asset,
    //  required Function(void Function())? setState
  }) async {
    DateTime now = DateTime.now();

    String domain = userData.domain;

    List<Map> results = [];

    int last7days =
        now.subtract(const Duration(days: 7)).millisecondsSinceEpoch;

    int last14days =
        now.subtract(const Duration(days: 14)).millisecondsSinceEpoch;

    var result1 = await GraphqlServices().performQuery(
      query: AssetSchema.getUtilizationData,
      variables: {
        "payload": {
          "startDate": last7days,
          "endDate": now.millisecondsSinceEpoch,
          "domain": domain,
          "assets": [
            asset,
          ],
        }
      },
    );

    if (result1.hasException) {
      return null;
    }

    GetUtilizationModel getUtilizationModelCurrentWeek =
        getUtilizationModelFromJson(result1.data!);

    GetUtilizationData? getUtilizationData =
        getUtilizationModelCurrentWeek.getUtilizationData;

    num? currentPeriodicOperationHours =
        getUtilizationData?.totalOperationalDuration;

    num? currentdailyOperationHours = getUtilizationData?.dailyAverage;

    num? currentUtilizationRate = getUtilizationData?.utilizationRate;

    String currentPeriodicOperationHoursData =
        currentPeriodicOperationHours == null
            ? "N/A"
            : convertDuration(Duration(
                milliseconds: currentPeriodicOperationHours.toInt(),
              ));

    String currentdailyOperationHoursData = currentdailyOperationHours == null
        ? "N/A"
        : convertDuration(Duration(
            milliseconds: currentdailyOperationHours.toInt(),
          ));

    results.addAll([
      {
        "label": "Periodic Operation Hours",
        // "previous": "30h 23m",
        "current": currentPeriodicOperationHoursData,
        // "perc": 15,
      },
      {
        "label": "Dialy Operation Hours",
        // "previous": "1h 30m",
        "current": currentdailyOperationHoursData,
        // "perc": 60,
      },
      {
        "label": "Utlization Rate (Avg)",
        // "previous": "35.4%",
        "current": currentUtilizationRate == null
            ? "N/A"
            : "${currentUtilizationRate.toStringAsFixed(2)}%",
      },
    ]);

    var result2 = await GraphqlServices().performQuery(
      query: AssetSchema.getUtilizationData,
      variables: {
        "payload": {
          "startDate": last14days,
          "endDate": last7days,
          "domain": domain,
          "assets": [
            asset,
          ],
        }
      },
    );

    if (result2.hasException) {
    }

    GetUtilizationModel getUtilizationModelPreviousWeek =
        getUtilizationModelFromJson(result2.data!);

    GetUtilizationData? getUtilizationDataPrevious =
        getUtilizationModelPreviousWeek.getUtilizationData;

    num? previousPeriodicOperationHours =
        getUtilizationDataPrevious?.totalOperationalDuration;

    num? previousdailyOperationHours = getUtilizationDataPrevious?.dailyAverage;

    num? previousUtilizationRate = getUtilizationDataPrevious?.utilizationRate;

    String previousPeriodicOperationHoursData =
        previousPeriodicOperationHours == null
            ? "N/A"
            : convertDuration(Duration(
                milliseconds: previousPeriodicOperationHours.toInt(),
              ));

    String previousdailyOperationHoursData = previousdailyOperationHours == null
        ? "N/A"
        : convertDuration(Duration(
            milliseconds: previousdailyOperationHours.toInt(),
          ));

    String previousUtilizationData = previousUtilizationRate == null
        ? "N/A"
        : "${previousUtilizationRate.toStringAsFixed(2)}%";

    results[0]['previous'] = previousPeriodicOperationHoursData;
    results[1]['previous'] = previousdailyOperationHoursData;
    results[2]['previous'] = previousUtilizationData;

    // results[0]['perc'] = 10;
    // results[1]['perc'] = 20;
    // results[2]['perc'] = 10;

    results[0]['perc'] = previousPeriodicOperationHours == null ||
            currentPeriodicOperationHours == null
        ? 0
        : previousPeriodicOperationHours < currentPeriodicOperationHours
            ? previousPeriodicOperationHours /
                currentPeriodicOperationHours *
                100.round()
            : currentPeriodicOperationHours /
                previousPeriodicOperationHours *
                100.round();

    results[1]['perc'] = previousdailyOperationHours == null ||
            currentdailyOperationHours == null
        ? 0
        : previousdailyOperationHours < currentdailyOperationHours
            ? previousdailyOperationHours /
                currentdailyOperationHours *
                100.round()
            : currentdailyOperationHours /
                previousdailyOperationHours *
                100.round();

    results[2]['perc'] =
        previousUtilizationRate == null || currentUtilizationRate == null
            ? 0
            : previousUtilizationRate > currentUtilizationRate
                ? previousUtilizationRate - currentUtilizationRate
                : currentUtilizationRate - previousUtilizationRate;

    results[0]['clr'] = previousPeriodicOperationHours == null
        ? Colors.white
        : previousPeriodicOperationHours < currentPeriodicOperationHours!
            ? Colors.red
            : Colors.green.shade700;

    results[1]['clr'] = previousdailyOperationHours == null
        ? Colors.white
        : previousdailyOperationHours < currentdailyOperationHours!
            ? Colors.red
            : Colors.green.shade700;

    results[2]['clr'] = previousUtilizationRate == null
        ? Colors.white
        : previousUtilizationRate < currentUtilizationRate!
            ? Colors.red
            : Colors.green.shade700;

    return results;
  }

  String convertDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m";
  }

// =============================================================================
// -------------------------------------------------------------

  Future<String?> scanQR() async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff",
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (barcodeScanRes == "-1") {
        return "cancelled";
      }

      String key = "Q6C0D3";

      var decrypted = EncryptionDecryptionServices()
          .decryptAESCryptoJS(barcodeScanRes, key);

      return decrypted;
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version";
      return null;
    } catch (e) {
      return null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

//  ================================================================================================

  Set<Marker> convertToMarkerData({
    required BuildContext context,
    required List<Assets> assets,
  }) {
    Set<Marker> customMarkers = {};

    for (var element in assets) {
      if (element.location != null) {
        LatLng? latLng = AssetsServices().parseWktPoint(element.location!);

        // Color color = getStatusColors(element.operationStatus ?? "");

        // String firstTitle = element.displayName!.split(RegExp(r'[\s_-]'))[0];

        // if (element.displayName!.contains("-")) {
        //   firstTitle = element.displayName!.split("-")[0];
        // } else {
        //   firstTitle = element.displayName!.split(" ")[0];
        // }

        if (latLng != null) {
          customMarkers.add(
            Marker(
              markerId: MarkerId(element.identifier!),
              position: latLng,
              infoWindow: InfoWindow(
                anchor: const Offset(2, 4),
                title: element.displayName,
                snippet: element.clientName,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(EquipmentDetailsScreen.id, arguments: {
                    "domain": element.domain,
                    "type": element.type,
                    "identifier": element.identifier,
                    "displayName": element.displayName,
                  });
                },
              ),
            ),
          );
        }
      }
    }

    return customMarkers;
  }

  Set<Marker> convertToMarkerLiveData({
    required BuildContext context,
    required FindAsset? findAsset,
  }) {
    Set<Marker> customMarkers = {};

    if (findAsset?.assetLatest?.location != null) {
      LatLng? latLng =
          AssetsServices().parseWktPoint(findAsset!.assetLatest!.location!);

      if (latLng != null) {
        customMarkers.add(
          Marker(
            markerId: MarkerId(findAsset.asset!.data!.identifier!),
            position: latLng,
            infoWindow: InfoWindow(
              anchor: const Offset(2, 4),
              title: findAsset.asset?.data?.displayName,
              snippet: findAsset.assetLatest?.clientName,
              onTap: () {
                // Map<String, dynamic> map = {
                //   "type": findAsset.asset?.type,
                //   "data": {
                //     "domain": findAsset.asset?.data?.domain,
                //     "identifier": findAsset.asset!.data!.identifier,
                //   }
                // };
              },
            ),
          ),
        );
      }
    }

    return customMarkers;
  }

// ===============================================================================================


  getCommunicationStartDateEndDate({required String communicationStatus}) {
    // print("Communication Status : $communicationStatus");

    String? appTheme = SharedPrefrencesServices().getData(key: "appTheme");

    Map<String, dynamic> map = appTheme == null ? {} : jsonDecode(appTheme);

    var now = DateTime.now();

    // print(map["assetCommunicationStatus"]["notConnected"]);

    Map<String, dynamic>? notConnectedDates =
        map["assetCommunicationStatus"]?["notConnected"];

    Map<String, dynamic>? communicatingDates =
        map["assetCommunicationStatus"]?["frequentlyCommunicating"];

    Map<String, dynamic>? lessCommunicatingDates =
        map["assetCommunicationStatus"]?["lessCommunicating"];

    Map<String, dynamic>? notCommunicatingDates =
        map["assetCommunicationStatus"]?["notCommunicating"];

    switch (communicationStatus) {
      case "CONNECTED":
        return {"startDate": -1, "endDate": 0};

      case "NOT_CONNECTED":
        int start = notConnectedDates?["start"] ?? 0;
        int end = notConnectedDates?["end"] ?? 0;

        var startDate = start != 0
            ? now
                .subtract(Duration(minutes: start))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        var endDate = end != 0
            ? now
                .subtract(Duration(minutes: end))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        return {
          "startDate": startDate,
          "endDate": endDate,
        };

      case "COMMUNICATING":
        int start = communicatingDates?["start"] ?? 0;
        int end = communicatingDates?["end"] ?? 0;

        var startDate = start != 0
            ? now
                .subtract(Duration(minutes: start))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        var endDate = end != 0
            ? now
                .subtract(Duration(minutes: end))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        return {
          "startDate": startDate,
          "endDate": endDate,
        };

      case "LESS_COMMUNICATING":
        int start = lessCommunicatingDates?["start"] ?? 0;
        int end = lessCommunicatingDates?["end"] ?? 0;

        var startDate = start != 0
            ? now
                .subtract(Duration(minutes: start))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        var endDate = end != 0
            ? now
                .subtract(Duration(minutes: end))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        return {
          "startDate": startDate,
          "endDate": endDate,
        };

      case "NON_COMMUNICATING":
        int start = notCommunicatingDates?["start"] ?? 0;
        int end = notCommunicatingDates?["end"] ?? 0;

        var startDate = start != 0
            ? now
                .subtract(Duration(minutes: start))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        var endDate = end != 0
            ? now
                .subtract(Duration(minutes: end))
                .toUtc()
                .millisecondsSinceEpoch
            : 0;

        return {
          "startDate": startDate,
          "endDate": endDate,
        };

      case "MAINTENANCE":
        return true;
      default:
    }

    // print("APP THEME MAP :  $map");
  }






}
