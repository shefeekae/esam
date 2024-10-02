import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/alarm_data_trend_chart.dart';
import 'package:nectar_assets/ui/shared/functions/date_helpers.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/date_range_button.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/sheets/custom_modal_bottomsheet.dart';
import 'package:sizer/sizer.dart';

class EquipmentDataTrendsScreen extends StatefulWidget {
  const EquipmentDataTrendsScreen({
    required this.criticalPoints,
    required this.points,
    required this.identifier,
    required this.domain,
    required this.type,
    super.key,
  });

  static const String id = 'equipment/data_trends';

  final List<String> criticalPoints;
  final List<String> points;
  final String identifier;
  final String domain;
  final String type;

  @override
  State<EquipmentDataTrendsScreen> createState() =>
      _EquipmentDataTrendsScreenState();
}

class _EquipmentDataTrendsScreenState extends State<EquipmentDataTrendsScreen> {
  final ThemeServices themeServices = ThemeServices();

  final ValueNotifier<List<String>> pointsSelectionNotifier =
      ValueNotifier<List<String>>([]);

  final ValueNotifier<DateTimeRange> dateRangeNotifier =
      ValueNotifier<DateTimeRange>(
          DateHelpers().getYesterdayStartTodayEndDateTimeRange());

  final DateHelpers dateHelpers = DateHelpers();

  @override
  void initState() {
    pointsSelectionNotifier.value = widget.criticalPoints;
    dateRangeNotifier.value =
        dateHelpers.getYesterdayStartTodayEndDateTimeRange();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipment Data Trends"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Column(
              children: [
                DateRangePickerButton(
                  initialDateTimeRange:
                      dateHelpers.getYesterdayStartTodayEndDateTimeRange(),
                  firstDate: dateHelpers.get30DaysDateRange().start,
                  endDate: dateHelpers.get30DaysDateRange().end,
                  onChanged: (dateTimeRange) {
                    dateRangeNotifier.value = dateTimeRange;
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                buildPoints(context),
              ],
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: pointsSelectionNotifier,
              builder: (context, values, _) => ValueListenableBuilder(
                valueListenable: dateRangeNotifier,
                builder: (context, dateRange, _) => EquipmentDataTrendsChart(
                  sourceId: widget.identifier,
                  pointNames: List.from(values),
                  sourceType: widget.type,
                  sourceDomain: widget.domain,
                  startDate: dateRange.start.millisecondsSinceEpoch,
                  endDate: dateRange.end.millisecondsSinceEpoch,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }

  // ====================================================================================
  Widget buildPoints(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomModalBottomSheet(
          context: context,
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  "Points",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 0,
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: pointsSelectionNotifier,
                    builder: (context, values, _) {
                      // ignore: prefer_collection_literals
                      List<String> list = [
                        ...widget.points,
                        ...widget.criticalPoints
                      ].toSet().toList();

                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          String pointName = list[index];

                          bool checked =
                              values.any((element) => element == list[index]);

                          return CheckboxListTile(
                            activeColor: Theme.of(context).primaryColor,
                            value: checked,
                            title: Text(pointName),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }

                              List<String> selectedPoints = values;

                              if (value) {
                                selectedPoints.add(pointName);
                              } else {
                                selectedPoints.remove(pointName);
                              }

                              pointsSelectionNotifier.value =
                                  List.from(selectedPoints);
                            },
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: BgContainer(
          child: ValueListenableBuilder(
              valueListenable: pointsSelectionNotifier,
              builder: (context, values, _) {
                if (values.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.sp,
                      horizontal: 5.sp,
                    ),
                    child: Text(
                      "Select Points",
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.sp),
                  child: Wrap(
                    spacing: 5.sp,
                    runSpacing: 0,
                    children: List.generate(
                      values.length > 5 ? 6 : values.length,
                      (index) {
                        if (index == 5) {
                          int moreValue = values.length - 5;

                          return Chip(
                            label: Text(
                              "+$moreValue",
                              style: TextStyle(
                                color:
                                    ThemeServices().getPrimaryFgColor(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          );
                        }

                        return Chip(
                          backgroundColor: Theme.of(context).primaryColor,
                          label: Text(
                            values[index],
                            style: TextStyle(
                              fontSize: 8.sp,
                            ),
                          ),
                          onDeleted: () {
                            List<String> selectedPoints = values;

                            selectedPoints.remove(selectedPoints[index]);

                            pointsSelectionNotifier.value =
                                List.from(selectedPoints);
                          },
                          deleteIconColor:
                              themeServices.getPrimaryFgColor(context),
                        );
                      },
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
