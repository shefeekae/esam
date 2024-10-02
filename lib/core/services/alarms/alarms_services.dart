import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_filter_form/shared/widgets/custom_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/services/file_services.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class AlarmsServices {
  UserDataSingleton userData = UserDataSingleton();
  // =================================================

  List getSuspectDataList(String? suspectData) =>
      jsonDecode(suspectData ?? "[]");

// =========================================================================

  Map<String, dynamic>? getSuspectElement(
      {required List list, required String pointName}) {
    return list
        .singleWhereOrNull((element) => element['pointName'] == pointName);
  }

//  ===============================================================================

  String getSuspectElementDataWithUnit({
    required List suspectDataList,
    required String pointName,
  }) {
    Map<String, dynamic>? data = getSuspectElement(
      list: suspectDataList,
      pointName: pointName,
    );

    if (data == null) {
      return "";
    }

    dynamic pointData = data['data'];

    if (pointData == null) {
      return "";
    }

    String unit = data['unit'] ?? "";

    if (unit == "dateTime") {
      try {
        return DateFormat.yMMMd()
            .add_jm()
            .format(DateTime.fromMillisecondsSinceEpoch(pointData));
      } catch (_) {
        return pointData;
      }
    }

    if (unit == "unitless") {
      return data['data'].toString();
    }

    return "$pointData $unit";
  }

  Future<void> openAlarmDashboardCard({
    required String fileType,
    required BuildContext context,
  }) async {
    String query =
        ''' query getAlarmDashboardReport(\$data: LevelBasedConsolidationInput) {
  getAlarmDashboardReport(data: \$data)
} ''';

    // String reportTitle = "Breakdown Job Card";

    showAdaptiveDialog(
      context: context,
      builder: (context) => Dialog(

          // insetPadding: EdgeInsets.symmetric(horizontal: 10.sp),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
                SizedBox(
                  width: 5.sp,
                ),
                const Text(
                  "File is loading, please wait...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );

    var result = await GraphqlServices().performQuery(query: query, variables: {
      "data": {
        "entity": {
          "type": userData.tenant["type"],
          "data": {
            "domain": userData.tenant["domain"],
            "identifier": userData.tenant["identifier"],
          }
        },
        "level": "COMMUNITY",
        "startDate": 1659292200000,
        "endDate": 1699468199999,
        "app": "Nectar Assets",
        "reportType": "PDF"
      }
    });

    if (result.hasException) {
      if (context.mounted) {
        buildSnackBar(
          context: context,
          value: "Something went wrong. Please try again",
        );

        Navigator.of(context).pop();
      }
      return;
    }

    String? data = result.data?['getAlarmDashboardReport']?['data'];
    String? fileName = result.data?['getAlarmDashboardReport']?['fileName'];

    Uint8List decodedbytes = base64Decode(data!);

    final directory = await getApplicationDocumentsDirectory();

    File file =
        await File("${directory.path}/$fileName.${getFileExtension(fileType)}")
            .writeAsBytes(decodedbytes);

    if (context.mounted) {
      if (!file.existsSync()) {
        buildSnackBar(
          context: context,
          value: "File not found",
        );
        return;
      }

      FileServices().openFile(file, context);

      Navigator.of(context).pop();
    }
  }

  //  ================================================
// Get file Extension

  String getFileExtension(String type) {
    switch (type) {
      case "PDF":
        return "pdf";

      case "EXCEL":
        return "xls";

      default:
        return "";
    }
  }
}
