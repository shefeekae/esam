import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/assets/affected_assets_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/widgets/equipment_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/search/equipments_search_delegate.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../core/models/asset/assets_list_model.dart';

class ShowAffectedEquipments extends StatefulWidget {
  const ShowAffectedEquipments(
      {required this.alarmName, required this.payload, super.key});

  final Map<String, dynamic> payload;
  final String alarmName;

  @override
  State<ShowAffectedEquipments> createState() => _ShowAffectedEquipmentsState();
}

class _ShowAffectedEquipmentsState extends State<ShowAffectedEquipments> {
  final PagingController<int, Assets> pagingController =
      PagingController<int, Assets>(firstPageKey: 0);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      AffectedEquipmentServices().getPaginatedAssetsList(
        pageKey: pageKey,
        pagingController: pagingController,
        extraPayload: widget.payload,
      );
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PermissionChecking(
        featureGroup: "assetManagement",
        feature: "assetList",
        permission: "list",
        showNoAccessWidget: true,
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
          ),
        ),
      ),
    );
  }

  // ===============================================================================

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "${widget.alarmName} Affected Equipments",
        maxLines: 2,
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: AssetSearchDelegate(
                  extraPayload: widget.payload,
                ));
          },
          icon: const Icon(
            Icons.search,
          ),
        )
      ],
    );
  }
}
