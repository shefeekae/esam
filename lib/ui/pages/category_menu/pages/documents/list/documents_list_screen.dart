import 'dart:convert';

import 'package:app_filter_form/app_filter_form.dart';
import 'package:app_filter_form/widgets/buttons/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/documents/document_list_model.dart';
import 'package:nectar_assets/core/services/documents/document_pagination_services.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/documents/search/document_list_search_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'widgets/document_list_tile.dart';

class DocumentsListScreen extends StatefulWidget {
  DocumentsListScreen({super.key});

  static const String id = 'documents/list';

  @override
  State<DocumentsListScreen> createState() => _DocumentsListScreenState();
}

class _DocumentsListScreenState extends State<DocumentsListScreen> {
  final UserDataSingleton userData = UserDataSingleton();

  late PayloadManagementBloc payloadManagementBloc;
  late PagingController<int, Result> pagingController;
  late FilterSelectionBloc filterSelectionBloc;
  late FilterAppliedBloc filterAppliedBloc;

  DocumentPaginationServices documentPaginationServices =
      DocumentPaginationServices();

  @override
  void initState() {
    payloadManagementBloc = BlocProvider.of<PayloadManagementBloc>(context);
    filterSelectionBloc = BlocProvider.of<FilterSelectionBloc>(context);
    filterAppliedBloc = BlocProvider.of<FilterAppliedBloc>(context);

    payloadManagementBloc.state.payload = {};

    pagingController = PagingController(firstPageKey: 1);

    pagingController.addPageRequestListener(
      (pageKey) {
        documentPaginationServices.getDocumentList(
            pagingController: pagingController,
            pageKey: pageKey,
            payloadManagementBloc: payloadManagementBloc);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    filterSelectionBloc.state.filterLabelsMap[FilterType.documents] = [];

    filterAppliedBloc.state.filterAppliedCount = 0;
    payloadManagementBloc.state.payload = {};

    super.dispose();
  }

  final bool hasPermission = UserPermissionServices().checkingPermission(
      featureGroup: "documentManagement",
      feature: "document",
      permission: "list");

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      Map<String, dynamic>? asset = args['asset'];

      if (asset != null) {
        int count = filterAppliedBloc.state.filterAppliedCount;
        filterAppliedBloc.state.filterAppliedCount = count + 1;
        payloadManagementBloc.state.payload.addAll(
          {
            "assets": [
              asset,
            ]
          },
        );
      }
    }

    return Scaffold(
      appBar: appBar(args),
      body: PermissionChecking(
        featureGroup: "documentManagement",
        feature: "document",
        permission: "list",
        showNoAccessWidget: true,
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            pagingController.refresh();
          },
          child: PagedListView.separated(
            pagingController: pagingController,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const Divider();
            },
            builderDelegate: PagedChildBuilderDelegate<Result>(
              itemBuilder: (context, item, index) {
                Result documentData = item;

                return DocumentListTiile(
                  documentResult: documentData,
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return TextButton.icon(
                  onPressed: () {
                    pagingController.retryLastFailedRequest();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                );
              },
              firstPageErrorIndicatorBuilder: (context) {
                return TextButton.icon(
                  onPressed: () {
                    pagingController.retryLastFailedRequest();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                );
              },
              firstPageProgressIndicatorBuilder: (context) {
                return const CircularProgressIndicator.adaptive();
              },
              newPageProgressIndicatorBuilder: (context) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return Padding(
                  padding: EdgeInsets.only(top: 15.sp),
                  child: Center(
                    child: Text(
                      "No items found",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
              noMoreItemsIndicatorBuilder: (context) {
                var itemsCount = pagingController.itemList?.length ?? 0;

                if (itemsCount < 3) {
                  return const SizedBox();
                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: const Center(
                    child: Text("No data to show"),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================================
  AppBar appBar(Map<String, dynamic>? args) {
    return AppBar(
      title: Text(
        args?['title'] ?? "Documents",
      ),
      actions: [
        Visibility(
          visible: hasPermission,
          child: IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: DocumentSearchDelegate());
              },
              icon: const Icon(Icons.search)),
        ),
        Visibility(
          visible: hasPermission,
          child: FilterButtonWidget(
            onPressed: () {
              Map<String, dynamic>? assetData = args?['asset'];

              FilterWidgetHelpers().filterBottomSheet(
                context: context,
                filterType: FilterType.documents,
                isMobile: true,
                initialValues: assetData != null
                    ? [
                        {
                          "key": "assets",
                          "identifier": assetData,
                          "values": [
                            {
                              "name": assetData['data']['displayName'],
                              "data": jsonEncode(assetData),
                            }
                          ]
                        }
                      ]
                    : [],
                saveButtonTap: (value) {
                  pagingController.refresh();
                },
              );
            },
            // icon: const Icon(Icons.filter_alt_outlined),
          ),
        ),
      ],
    );
  }
}
