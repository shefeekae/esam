// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/alarms/alarms_pagination_services.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';
import 'alarm_card_widget.dart';

class AlarmsConsole extends StatefulWidget {
  const AlarmsConsole({
    super.key,
    required this.pagingController,
    this.showComments = true,
    this.showChart = true,
  });

  final PagingController<int, EventLogs> pagingController;

  // This used for alarms list in equipment consolidation
  final bool showComments;
  final bool showChart;

  @override
  State<AlarmsConsole> createState() => _AlarmsConsoleState();
}

class _AlarmsConsoleState extends State<AlarmsConsole> {

  final AlarmsPaginationServices alarmsPaginationServices =
      AlarmsPaginationServices();

  @override
  void initState() {
    PayloadManagementBloc payloadManagementBloc =
        BlocProvider.of<PayloadManagementBloc>(context);

    widget.pagingController.addPageRequestListener(
      (pageKey) {
        alarmsPaginationServices.getAlarmsList(
          pagingController: widget.pagingController,
          pageKey: pageKey,
          payloadManagementBloc: payloadManagementBloc,
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        widget.pagingController.refresh();
      },
      child: PagedListView.separated(
          pagingController: widget.pagingController,
          // physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10.sp);
          },
          builderDelegate: PagedChildBuilderDelegate<EventLogs>(
            itemBuilder: (context, item, index) {
              return AlarmCard(
                item: item,
                showchart: widget.showChart,
                showComments: widget.showComments,
                pagingController: widget.pagingController,
              );
            },
            newPageErrorIndicatorBuilder: (context) {
              return TextButton.icon(
                onPressed: () {
                  widget.pagingController.retryLastFailedRequest();
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
              var itemsCount = widget.pagingController.itemList?.length ?? 0;

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
    );
  }

  // ==============================================================================
  Widget buildIconWithText(IconData icon, String label) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 13.sp,
              color: Colors.grey,
            ),
            SizedBox(
              width: 2.sp,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 8.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
