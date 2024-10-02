import 'package:app_filter_form/app_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/alarms/alarms_pagination_services.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';
import 'fire_alarm_card.dart';

class FireAlarmsPaginatedBuilder extends StatefulWidget {
  const FireAlarmsPaginatedBuilder({
    required this.controller,
    required this.pagingController,
    super.key,
  });

  final ScrollController controller;

  final PagingController<int, EventLogs> pagingController;

  @override
  State<FireAlarmsPaginatedBuilder> createState() =>
      _FireAlarmsPaginatedBuilderState();
}

class _FireAlarmsPaginatedBuilderState
    extends State<FireAlarmsPaginatedBuilder> {
  @override
  void initState() {
    PayloadManagementBloc payloadManagementBloc =
        BlocProvider.of<PayloadManagementBloc>(context);

    widget.pagingController.addPageRequestListener(
      (pageKey) {
        AlarmsPaginationServices().getAlarmsList(
          pagingController: widget.pagingController,
          pageKey: pageKey,
          payloadManagementBloc: payloadManagementBloc,
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        widget.pagingController.refresh();
      },
      child: PagedListView.separated(
          scrollController: widget.controller,
          pagingController: widget.pagingController,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10.sp);
          },
          builderDelegate: PagedChildBuilderDelegate<EventLogs>(
            itemBuilder: (context, item, index) {
              return FireAlarmCard(
                eventLogs: item,
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                child: Column(
                  children: List.generate(
                      3,
                      (index) => Padding(
                          padding: EdgeInsets.only(bottom: 10.sp),
                          child: ShimmerLoadingContainerWidget(height: 50.sp))),
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
                    "No Active Alarms Found",
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
