import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/documents/document_asset_model.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/schemas/documents_schemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../shared/widgets/container_with_text.dart';

class DocumentDetails extends StatelessWidget {
  const DocumentDetails({
    super.key,
    required this.documentResult,
  });

  final Result documentResult;

  @override
  Widget build(BuildContext context) {
    List<DocumentCategory> documentCategories =
        documentResult.documentCategory ?? [];

    String expiryDateString = documentResult.document?.data?.expiryDate ?? "";

    DateTime issueDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(documentResult.document?.data?.issuedDate ?? ""));


    DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(documentResult.document?.data?.expiryDate ?? "") ?? 0);

    var payload = {
      "data": {
        "entity": {
          "type": documentResult.document?.type ?? "",
          "data": documentResult.document?.data?.toJson(),
        }
      }
    };


    return Container(
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Visibility(
            visible: documentCategories.isNotEmpty,
            child: Column(
              children: [
                buildListTileMultipleValues(
                  title: "Categories",
                  value: documentCategories
                      .map((e) => e.data?.name ?? "")
                      .toList(),
                ),
                const Divider(),
              ],
            ),
          ),
          // const Divider(),
          QueryWidget(
            options: GraphqlServices().getQueryOptions(
              query:
                  DocumentSchema.getMappedEntitiesWithDocumentLatestDataQuery,
              variables: payload,
            ),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const CircularProgressIndicator.adaptive();
              }

              if (result.hasException) {
                return GrapghQlClientServices().handlingGraphqlExceptions(
                    result: result, context: context, refetch: refetch);
              }

              var data = result.data;

              DocumentAssetListModel documentAssetListModel =
                  documentAssetListModelFromJson(data ?? {});

              List<Asset> assetList = documentAssetListModel
                      .getMappedEntitiesWithDocumentLatestData?.assets ??
                  [];

              return Visibility(
                visible: assetList.isNotEmpty,
                child: Column(
                  children: [
                    const Divider(),
                    buildListTileMultipleValues(
                      title: "Assets",
                      value: assetList.map((e) => e.displayName ?? "").toList(),
                    ),
                  ],
                ),
              );
            },
          ),

          buildListTile(
              title: "Validity",
              value: documentResult.document?.data?.validity ?? ""),
          const Divider(),
          buildListTile(
              title: "Issued Date",
              value: DateFormat("dd MMM yyyy").format(issueDate)),
          const Divider(),
          buildListTile(
              title: "Expires On",
              value: expiryDateString.isEmpty
                  ? ""
                  : DateFormat("dd MMM yyyy").format(expiryDate))
        ],
      ),
    );
  }

  // ===========================================================================

  Widget buildListTile({
    required String title,
    required String value,
  }) {
    if (value.isEmpty) {
      return const SizedBox();
    }

    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===========================================================================

  Widget buildListTileMultipleValues({
    required String title,
    required List<String> value,
  }) {
    if (value.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   width: 10.sp,
          // ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: 5.sp,
              runSpacing: 5.sp,
              children: List.generate(
                value.length,
                (index) => ContainerWithTextWidget(
                  value: value[index],
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: 10.sp,
          // ),
        ],
      ),
    );
    //  ListTile(
    //   // isThreeLine: true,
    //   title: Text(
    //     title,
    //   ),
    //   trailing: ConstrainedBox(
    //     constraints: BoxConstraints.loose(Size.fromWidth(
    //       60.w,
    //     )),
    //     child: Wrap(
    //       spacing: 5.sp,
    //       runSpacing: 5.sp,
    //       children: List.generate(
    //         10,
    //         (index) => ContainerWithTextWidget(
    //           value: value,
    //           fontSize: 10.sp,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
