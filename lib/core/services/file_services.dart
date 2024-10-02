import 'dart:io';
import 'package:graphql_config/graphql_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nectar_assets/core/schemas/files_schemas.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:share_plus/share_plus.dart';
import '../../ui/shared/widgets/custom_snackbar.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:path/path.dart' as path;

class FileServices {
// =========Share Image=============================================================================

  final UserDataSingleton userData = UserDataSingleton();

  void shareImage({
    required String imagePath,
  }) {
    Share.shareXFiles([XFile(imagePath)]);
  }

// =======Download Image==============================================================================

  void downloadImagesToGallery({
    required String imagePath,
    required BuildContext context,
  }) async {
    bool? isSuccess =
        await GallerySaver.saveImage(imagePath, albumName: "Nectar Assets");

    print("image bool success : $isSuccess");

    if (isSuccess == null || !isSuccess) {
      // ignore: use_build_context_synchronously
      buildSnackBar(
        context: context,
        value: "Image download failed",
      );
    } else {
      // ignore: use_build_context_synchronously
      buildSnackBar(
        context: context,
        value: "Image downloaded successfully!",
      );
    }
  }

  // -------------------------------------------------
// AttachFiles

  Future<void> attachBreakDownStatusFiles({
    required File attachedFile,
    required BuildContext context,
    required String identifier,
    required int dateTimeEpoch,
  }) async {
    var byteData = await attachedFile.readAsBytes();

    // var documentary = await getApplicationDocumentsDirectory();

    // String maintenanceCondition = isBreakdown ? "breakdowns" : "service";

    String fileName = path.basename(attachedFile.path);
    String extension = attachedFile.path.split('.').last;

    final multipartFile = http.MultipartFile.fromBytes(
      'file',
      byteData,
      filename: fileName,
      contentType: MediaType("image", extension),
    );

    String domain = userData.domain;

    // ignore: use_build_context_synchronously
    var result = await GrapghQlClientServices().performMutation(
      context: context,
      mutation: FilesSchemas.uploadMultipleFilesMutation,
      variables: {
        "data": [
          {
            "file": multipartFile,
            "name": fileName,
            "filePath": "assets/$domain/$identifier/breakdowns/$dateTimeEpoch",
          },
        ],
      },
    );

    if (result.hasException) {
      print("exception called");
      print(result.exception);
      return;
    }

    print(result.data);
  }

  void openFile(File file, BuildContext context) async {
    try {
      var result = await OpenFile.open(file.path);
      print("Result message ${result.message}");
      // ignore: use_build_context_synchronously
      if (result.type == ResultType.noAppToOpen) {
        // ignore: use_build_context_synchronously
        buildSnackBar(
          context: context,
          value: "No APP found to open this file。",
        );
      } else if (result.type == ResultType.error) {
        // ignore: use_build_context_synchronously
        buildSnackBar(
          context: context,
          value: "Something went wrong",
        );
      } else if (result.type == ResultType.permissionDenied) {
        // ignore: use_build_context_synchronously
        buildSnackBar(
          context: context,
          value: "Permission denied",
        );
      }
    } catch (e) {
      buildSnackBar(
        context: context,
        value: "Can't open this file",
      );
      // TODO
    }
  }
}
