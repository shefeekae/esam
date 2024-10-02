import 'package:app_filter_form/core/services/platform_services.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_list_model.dart';
import 'package:nectar_assets/core/services/scheduler/scheduler_list_pagination_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/widgets/scheduler_card.dart';
import 'package:sizer/sizer.dart';

class SchedulerList extends StatefulWidget {
  const SchedulerList({super.key});

  @override
  State<SchedulerList> createState() => _SchedulerListState();
}

class _SchedulerListState extends State<SchedulerList> {
  final PagingController<int, Items> pagingController =
      PagingController<int, Items>(firstPageKey: 0);

  final ValueNotifier<Map<String, DateTime>?> dateRangNotifier =
      ValueNotifier<Map<String, DateTime>?>(null);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      SchedulerPaginationServices().getPagintedSchedulesList(
        pagingController: pagingController,
        pageKey: pageKey,
      );
    });
    // TODO: implement initState
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
    return Column(
      children: [
        SizedBox(
          height: 5.sp,
        ),
        Center(
          child: buildDateRangeButton(context),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Expanded(
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              pagingController.refresh();
            },
            child: buildPaginatedSchedulesList(),
          ),
        )
      ],
    );
  }

  // ==============================================================================
  //

  Widget buildPaginatedSchedulesList() {
    return PagedListView.separated(
        pagingController: pagingController,
        separatorBuilder: (context, index) {
          return SizedBox(height: 7.sp);
        },
        builderDelegate: PagedChildBuilderDelegate<Items>(
          itemBuilder: (context, item, index) {
            return SchedulerCard(item: item);
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
        ));
  }

  // =========================================================================================
  Widget buildDateRangeButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Map<String, DateTime>? dateRangeValue = dateRangNotifier.value;

        DateTimeRange? dateTimeRange =
            await PlatformServices().showPlatformDateRange(
          context,
          dateRangeValue == null
              ? null
              : DateTimeRange(
                  start: dateRangeValue['startDate']!,
                  end: dateRangeValue['endDate']!,
                ),
        );

        if (dateTimeRange != null) {
          // pagingController.nextPageKey = 0;

          SchedulerPaginationServices().getPagintedSchedulesList(
            pagingController: pagingController,
            pageKey: 0,
            startDate: dateTimeRange.start.millisecondsSinceEpoch,
            endDate: dateTimeRange.end.millisecondsSinceEpoch,
            dateRangeCalled: true,
          );

          dateRangNotifier.value = {
            "startDate": dateTimeRange.start,
            "endDate": dateTimeRange.end,
          };
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getBgColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ValueListenableBuilder(
          valueListenable: dateRangNotifier,
          builder: (context, value, _) {
            String startDateValue = value == null
                ? "Start Date"
                : DateFormat("MMM d y").format(value['startDate']!);

            String endDateValue = value == null
                ? "End Date"
                : DateFormat("MMM d y").format(value['endDate']!);

            TextStyle textStyle = TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: value == null ? Colors.grey : null,
            );

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(startDateValue, style: textStyle),
                SizedBox(
                  width: 10.sp,
                ),
                SizedBox(
                  width: 12.sp,
                  child: const Divider(
                    thickness: 1.5,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Text(
                  endDateValue,
                  style: textStyle,
                ),
                SizedBox(
                  width: 20.sp,
                ),
                const Icon(Icons.date_range)
              ],
            );
          },
        ),
      ),
    );
  }
}
