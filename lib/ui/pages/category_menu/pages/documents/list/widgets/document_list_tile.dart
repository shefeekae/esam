import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/services/documents/document_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/details/document_details.dart';
import 'package:sizer/sizer.dart';

class DocumentListTiile extends StatelessWidget {
  DocumentListTiile({
    super.key,
    required this.documentResult,
  });

  final String title = "Truck Driver Licence";

  final Result documentResult;

  // String getExpiryMessage(){

  // }

  final documentServices = DocumentServices();

  @override
  Widget build(BuildContext context) {
    final Data? documentData = documentResult.document?.data;

    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(DocumentDetailsScreen.id, arguments: {
          "title": title,
          "documentResult": documentResult,
        });
      },
      leading: getDocumentThumbnail(documentData?.fileType ?? ""),
      title: Text(
        documentData?.name ?? "",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        documentServices
            .getExpiryMessage(documentResult.document?.data?.expiryDate ?? ""),
      ),
      trailing: Icon(
        Icons.circle,
        color: documentServices
                .expireCheck(documentResult.document?.data?.expiryDate ?? "")
            ? Colors.green
            : Colors.red,
        size: 10.sp,
      ),
    );
  }
}

getDocumentThumbnail(String fileType) {
  switch (fileType.toUpperCase()) {
    // case "PNG":
    //   return Image.asset(
    //     "assets/images/png.png",
    //     height: 35.sp,
    //   );
    case "PDF":
      return Image.asset(
        "assets/images/pdf.png",
        height: 35.sp,
      );

    case "JPEG":
    case "PNG":
      return Image.asset(
        "assets/images/icons8-image-48.png",
        height: 35.sp,
      );

    default:
      return Image.asset("assets/images/icons8-file-48.png");
  }
}
