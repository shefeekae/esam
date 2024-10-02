import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/schemas/documents_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_snackbar.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

class DocumentServices {
  String getExpiryMessage(
    String expiryDate,
  ) {
    if (expiryDate.isEmpty) {
      return "Never Expires";
    }

    DateTime expiryDateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(expiryDate) ?? 0);

    String formatedDate = DateFormat("dd MMM yyy").format(expiryDateTime);

    if (expiryDateTime.isBefore(DateTime.now())) {
      return "Expired on $formatedDate";
    }

    return "Expiring on $formatedDate";
  }

  bool expireCheck(String expiryDate) {
    if (expiryDate.isEmpty) {
      return true;
    }

    DateTime expiryDateTime =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(expiryDate) ?? 0);

    return expiryDateTime.isAfter(DateTime.now());
  }
  
  openFile(
  String fileName,
  String fileDomain,
  String fileType,
  BuildContext context,
) async {
  showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      // insetPadding: EdgeInsets.symmetric(horizontal: 10.sp),
      // alignment: Alignment.center,

      title: const Text("File is loading .."),
      titlePadding: EdgeInsets.only(bottom: 5.sp),
      contentPadding: EdgeInsets.only(top: 5.sp),
      content: const CircularProgressIndicator.adaptive(),
    ),
  );

  var result = await GraphqlServices().performQuery(
    query: DocumentSchema.getFilePreviewQuery,
    variables: {
      "fileName": fileName,
      "filePath": "documents/$fileDomain",
    },
  );

  if (result.hasException) {
    if (context.mounted) {
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          content: const Text("Please try again"),
          title: const Text("Error loading file"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Ok"))
          ],
        ),
      );
    }
  }

  if (result.data == null) {
    if (context.mounted) {
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          content: const Text("No document uploaded"),
          title: const Text("Alert"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Ok"))
          ],
        ),
      );
    }
  }

  // var fileData = result.data!["getFileForPreview"];

  // print(result.data);

  String? base64Encoded = result.data?['getFileForPreview']?['data'];

  if (base64Encoded == null) {
    return;
  }

  Uint8List decodedbytes = base64Decode(base64Encoded);

  //   // Write the bytes to a file
  //   File('decoded.txt').writeAsBytesSync(bytes);
  final directory = await getApplicationDocumentsDirectory();

  File file =
      await File("${directory.path}/$fileName").writeAsBytes(decodedbytes);

  if (context.mounted) {
    if (!file.existsSync()) {
      buildSnackBar(
        context: context,
        value: "File not found",
      );
      return;
    }

    OpenFile.open(file.path);

    Navigator.of(context).pop();
  }
}
  
}
