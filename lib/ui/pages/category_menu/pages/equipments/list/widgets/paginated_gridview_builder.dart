import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/services/assets/assets_pagination_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/widgets/equipment_card.dart';
import 'package:sizer/sizer.dart';

class PaginatedEquipmentListBuilder extends StatefulWidget {
  const PaginatedEquipmentListBuilder({
    super.key,
    // required this.assets,
    required this.controller,
    required this.payloadManagementBloc,
    required this.pagingController,
  });

  final PayloadManagementBloc payloadManagementBloc;
  final ScrollController controller;
  final PagingController<int, Assets> pagingController;

  // final List<Assets> assets;

  @override
  State<PaginatedEquipmentListBuilder> createState() =>
      _PaginatedEquipmentListBuilderState();
}

class _PaginatedEquipmentListBuilderState
    extends State<PaginatedEquipmentListBuilder> {
  @override
  void initState() {
    widget.pagingController.addPageRequestListener((pageKey) {
      AssetsPaginationServices().getPaginatedAssetsList(
          pageKey: pageKey,
          payloadManagementBloc: widget.payloadManagementBloc,
          pagingController: widget.pagingController);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      padding: EdgeInsets.all(8.sp),
      pagingController: widget.pagingController,
      scrollController: widget.controller,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.sp,
        crossAxisSpacing: 10.sp,
        childAspectRatio: 2 / 2.3,
      ),
      builderDelegate: PagedChildBuilderDelegate<Assets>(
        itemBuilder: (context, item, index) {
          return EquipmentCard(
            asset: item,
          );
        },
        newPageErrorIndicatorBuilder: (context) {
          return TextButton.icon(
            // style: ElevatedButton.styleFrom(
            //   backgroundColor: Theme.of(context).primaryColor,
            // ),
            onPressed: () {
              widget.pagingController.retryLastFailedRequest();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
          );
        },
        firstPageProgressIndicatorBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
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
        // noMoreItemsIndicatorBuilder: (context) {
        //   var itemsCount = pagingController.itemList?.length ?? 0;

        //   if (itemsCount < 3) {
        //     return const SizedBox();
        //   }

        //   return Padding(
        //     padding: EdgeInsets.symmetric(vertical: 10.sp),
        //     child: const Center(
        //       child: Text("No data to show"),
        //     ),
        //   );
        // },
      ),
    );
  }
}
