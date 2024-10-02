import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/services/documents/document_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/details/widgets/description_or_content_widget.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/list/widgets/document_list_tile.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'widgets/document_details_card.dart';

class DocumentDetailsScreen extends StatelessWidget {
  const DocumentDetailsScreen({super.key});

  static const String id = '/documents/details';

  @override
  Widget build(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    Result documentResult = arg?['documentResult'];

    Data? documentData = documentResult.document?.data;

    String description =
        Uri.decodeComponent(documentResult.document?.data?.description ?? "");

    String content =
        Uri.decodeComponent(documentResult.document?.data?.content ?? "");

    String fileName = documentData?.fileLocation ?? "";

    String fileDomain = documentData?.domain ?? "";

    String fileType = documentData?.fileType ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(documentData?.name ?? ""),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: PermissionChecking(
          featureGroup: "documentManagement",
          feature: "document",
          permission: "view",
          showNoAccessWidget: true,
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      height: 15.h,
                      // width: 30.sp,
                      child: getDocumentThumbnail(documentData?.fileType ?? ""),
                    ),
                  ),
                  DescriptionOrContentWidget(
                    title: "Description",
                    content: description,
                  ),
                  DescriptionOrContentWidget(
                      content: content, title: "Content"),
                  SizedBox(
                    height: 15.sp,
                  ),
                  DocumentDetails(
                    documentResult: documentResult,
                  )
                ],
              ),
              Builder(builder: (context) {
                bool? isLoading;

                return CustomElevatedButton(
                  title: "Open file",
                  isLoading: isLoading ?? false,
                  onPressed: () {
                    DocumentServices()
                        .openFile(fileName, fileDomain, fileType, context);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
