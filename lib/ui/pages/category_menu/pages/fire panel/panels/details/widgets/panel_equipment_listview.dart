import 'package:app_filter_form/core/blocs/filter/payload/payload_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/services/assets/assets_pagination_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/widgets/equipment_card.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PanelEquipmentsListView extends StatefulWidget {
  const PanelEquipmentsListView({
    super.key,
    required this.assetsPagingController,
    required this.domain,
    required this.identifier,
  });

  final PagingController<int, Assets> assetsPagingController;
  final String domain;
  final String identifier;

  @override
  State<PanelEquipmentsListView> createState() =>
      _PanelEquipmentsListViewState();
}

class _PanelEquipmentsListViewState extends State<PanelEquipmentsListView> {
  UserDataSingleton userData = UserDataSingleton();

  @override
  void initState() {
    Map<String, dynamic> initialPayload = {
      "order": "asc",
      "sortField": "displayName",
      "entities": [
        {
          "type": "FACP",
          "data": {
            "identifier": widget.identifier,
            "domain": widget.domain,
          }
        }
      ]
    };

    PayloadManagementBloc payloadManagementBloc =
        BlocProvider.of<PayloadManagementBloc>(context);


    payloadManagementBloc.state.payload.remove("status");


    widget.assetsPagingController.addPageRequestListener((pageKey) {
      AssetsPaginationServices().getPaginatedAssetsList(
        pageKey: pageKey,
        payloadManagementBloc: payloadManagementBloc,
        pagingController: widget.assetsPagingController,
        additionalPayload: initialPayload,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        widget.assetsPagingController.refresh();
      },
      child: PagedListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        shrinkWrap: true,
        pagingController: widget.assetsPagingController,
        builderDelegate: PagedChildBuilderDelegate<Assets>(
          itemBuilder: (context, item, index) {
            return PanelEquipmentCard(
              asset: item,
            );
          },
          newPageErrorIndicatorBuilder: (context) {
            return TextButton.icon(
              onPressed: () {
                widget.assetsPagingController.retryLastFailedRequest();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return BuildShimmerLoadingWidget(
              itemCount: 10,
              height: 100.sp,
              shrinkWrap: true,
              padding: 0,
              borderRadius: 0,
            );
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
            var itemsCount =
                widget.assetsPagingController.itemList?.length ?? 0;

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
        separatorBuilder: (context, index) => SizedBox(
          height: 10.sp,
        ),
      ),
    );
  }
}
