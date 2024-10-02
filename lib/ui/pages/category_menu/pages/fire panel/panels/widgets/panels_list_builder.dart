import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/panels/fire_panels_list_model.dart';
import 'package:nectar_assets/core/services/panels/panels_pagination_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/widgets/panel_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../shared/widgets/loading_widget.dart';

class PanelsPaginationBuilder extends StatefulWidget {
  const PanelsPaginationBuilder({super.key});

  @override
  State<PanelsPaginationBuilder> createState() =>
      _PanelsPaginationBuilderState();
}

class _PanelsPaginationBuilderState extends State<PanelsPaginationBuilder> {
  final PagingController<int, Assets> pagingController =
      PagingController<int, Assets>(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      PanelsPaginationServices().getPanelsList(
        pagingController: pagingController,
        pageKey: pageKey,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        pagingController.refresh();
      },
      child: PagedListView.separated(
          pagingController: pagingController,
          padding: EdgeInsets.symmetric(horizontal: 7.sp),
          separatorBuilder: (context, index) {
            return SizedBox(height: 5.sp);
          },
          builderDelegate: PagedChildBuilderDelegate<Assets>(
            itemBuilder: (context, item, index) {
              return PanelCard(
                panel: item,
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
            firstPageProgressIndicatorBuilder: (context) {
              return Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 10.sp),
                    child: ShimmerLoadingContainerWidget(height: 100.sp),
                  ),
                ),
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
              var itemsCount = pagingController.itemList?.length ?? 0;

              if (itemsCount < 5) {
                return const SizedBox();
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: const Center(
                  child: Text("No data to show"),
                ),
              );
            },
          )),
    );
  }
}
