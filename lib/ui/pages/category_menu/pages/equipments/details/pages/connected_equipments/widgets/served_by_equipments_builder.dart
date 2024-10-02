import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/asset/assets_list_model.dart';
import 'package:nectar_assets/core/services/assets/assets_pagination_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/widgets/equipment_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../../../core/enums/equipment_enums.dart';
import '../../../../../../../../../core/services/theme/theme_services.dart';

class ServedByEquipmentsPagedGridBuilder extends StatefulWidget {
  const ServedByEquipmentsPagedGridBuilder({
    super.key,
    required this.assetEntity,
  });

  final Map<String, dynamic> assetEntity;

  @override
  State<ServedByEquipmentsPagedGridBuilder> createState() =>
      _ServedByEquipmentsPagedGridBuilderState();
}

class _ServedByEquipmentsPagedGridBuilderState
    extends State<ServedByEquipmentsPagedGridBuilder> {
  final PagingController<int, Assets> pagingController =
      PagingController<int, Assets>(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      AssetsPaginationServices().getPaginatedServedByORServedToAssetsList(
        pageKey: pageKey,
        assetEntity: widget.assetEntity,
        pagingController: pagingController,
        connectedEquipment: ConnectedEquipments.servedByEquipments,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        pagingController.refresh();
      },
      child: PagedGridView(
        padding: EdgeInsets.all(8.sp),
        pagingController: pagingController,
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
              bgColor: ThemeServices().getBgColor(context),
            );
          },
          newPageErrorIndicatorBuilder: (context) {
            return TextButton.icon(
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Theme.of(context).primaryColor,
              // ),
              onPressed: () {
                pagingController.retryLastFailedRequest();
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
      ),
    );
  }
}
