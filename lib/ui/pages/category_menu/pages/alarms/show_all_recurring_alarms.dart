import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/alarms/alarms_pagination_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/widgets/alarm_card_widget.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../core/models/list_alarms_model.dart';
import '../../../../shared/widgets/loading_widget.dart';

class ShowAllRecurringAlarms extends StatefulWidget {
  ShowAllRecurringAlarms({
    required this.alarmName,
    required this.payload,
    super.key,
  });

  final String alarmName;
  final Map<String, dynamic> payload;

  @override
  State<ShowAllRecurringAlarms> createState() => _ShowAllRecurringAlarmsState();
}

class _ShowAllRecurringAlarmsState extends State<ShowAllRecurringAlarms> {
  final PagingController<int, EventLogs> pagingController =
      PagingController<int, EventLogs>(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      AlarmsPaginationServices().getRecurringAlarmsList(
        pagingController: pagingController,
        pageKey: pageKey,
        payload: widget.payload,
      );
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppbar(),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            pagingController.refresh();
          },
          child: PagedListView.separated(
              pagingController: pagingController,
              // physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.sp);
              },
              builderDelegate: PagedChildBuilderDelegate<EventLogs>(
                itemBuilder: (context, item, index) {
                  return AlarmCard(
                    item: item,
                    showchart: true,
                    showComments: true,
                    pagingController: pagingController,
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
              )),
        ));
  }

  // ============================================================
  AppBar buildAppbar() {
    return AppBar(
      title: Text(
        "${widget.alarmName} - Alarms",
        maxLines: 2,
      ),
    );
  }
}
