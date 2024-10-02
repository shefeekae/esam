import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/functions/alarm_path.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/functions/get_status_colors_text.dart';
import 'package:nectar_assets/ui/shared/pages/work_order/work_order_details_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../shared/widgets/container_with_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'alarm_data_trend_chart.dart';

class AlarmHeaderCard extends StatelessWidget {
  const AlarmHeaderCard({
    super.key,
    // this.chartData,
    this.showChart = true,
    this.showCriticalPoints = true,
    required this.item,
  });

  final EventLogs? item;
  final bool showChart;
  final bool showCriticalPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            SizedBox(
              height: 5.sp,
            ),
            buildAlarmPath(),
            SizedBox(
              height: 5.sp,
            ),
            buildAreaChart(),
            SizedBox(
              height: 10.sp,
            ),
            buildCriticialPointsAndWorkOrderNO(context),
          ],
        ),
      ),
    );
  }

  // ==============================================================================

  Widget buildIconWithText(IconData icon, String label) {
    return Row(
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
    );
  }

  // =====================================================================================================

  Widget buildCriticialPointsAndWorkOrderNO(BuildContext context) {
    List list = jsonDecode(item?.suspectData ?? "[]");

    List<String> names = list.map((e) {
      String pointName = e['pointName'] ?? '';
      dynamic data = e['data'] ?? '';
      String unit = e['unit'] ?? "";

      if (unit != "unitless") {
        String unitSymbol = e['unitSymbol'] ?? "";

        return "$pointName: $data $unitSymbol";
      } else if (pointName == "Last Reported Time" ||
          pointName == "First Reported Time") {
        try {
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data.toInt());
          String formated = DateFormat("MMM dd yyyy").add_jm().format(dateTime);

          return '$pointName: $formated';
        } catch (e) {
          return "$pointName: $data";
        }
      }

      return "$pointName: $data";
    }).toList();

    String? workOrderNumber = item?.workOrderNumber;
    String? workOrderId = item?.workOrderId;

    if (workOrderNumber == null && !showCriticalPoints) {
      return const SizedBox();
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Wrap(runSpacing: 5.sp, spacing: 5.sp, children: [
            Visibility(
              visible: workOrderNumber != null,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return WorkOrderDetailsScreen(
                        workOrderId: workOrderId ?? "",
                      );
                    },
                  ));
                },
                child: ContainerWithTextWidget(
                  bgColor: Theme.of(context).primaryColor,
                  value: "WO #${item?.workOrderNumber}",
                  fontSize: 8.sp,
                  borderRadius: 8.sp,
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
                ),
              ),
            ),
            if (showCriticalPoints)
              ...names
                  .map(
                    (e) => ContainerWithTextWidget(
                      bgColor: Theme.of(context).primaryColor,
                      value: e,
                      fontSize: 8.sp,
                      borderRadius: 8,
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.sp, vertical: 2.sp),
                    ),
                  )
                  .toList(),
          ]),
        ),
        SizedBox(
          height: 5.sp,
        )
      ],
    );
  }
  // ==========================================================================================

  Widget buildAreaChart() {
    List<dynamic> suspectData = jsonDecode(item?.suspectData ?? "");

    List pointNames = suspectData.map((e) => e["pointName"]).toList();

    return Visibility(
      // visible: chartData != null,
      visible: showChart,
      child: Column(
        children: [
          EquipmentDataTrendsChart(
            sourceId: item?.sourceId ?? "",
            sourceType: item?.sourceType ?? "",
            sourceDomain: item?.sourceDomain ?? "",
            pointNames: pointNames,
          ),
          // SfCartesianChart(
          //   trackballBehavior: TrackballBehavior(
          //     enable: true,
          //     activationMode: ActivationMode.singleTap,
          //     tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          //     builder: (context, trackballDetails) {
          //       return Container(
          //         color: Colors.red,
          //       );
          //     },
          //   ),
          //   primaryXAxis: DateTimeCategoryAxis(
          //     plotBands: [
          //       PlotBand(
          //         start: DateTime(2023, 01, 01, 01, 01, 35),
          //         end: DateTime(2023, 01, 01, 01, 01, 45),
          //         associatedAxisEnd: 20,
          //         color: Colors.orange.shade400,
          //       ),
          //     ],
          //   ),
          //   series: [
          //     LineSeries<ChartData, int>(
          //       dataSource: chartData ?? [],
          //       xValueMapper: (datum, index) => datum.x,
          //       yValueMapper: (datum, index) => datum.y,
          //     )
          //   ],
          // ),
          // SfCartesianChart(
          //   primaryXAxis: DateTimeAxis(
          //     dateFormat: DateFormat.Hm(),
          //   ),
          //   legend: Legend(
          //     isVisible: true,
          //     alignment: ChartAlignment.near,
          //   ),
          //   series: const <ChartSeries>[],
          // ),
          SizedBox(
            height: 5.sp,
          ),
        ],
      ),
    );
  }

  // =======================================================================================

  Widget buildAlarmPath() {
    return Text(
      getAlarmsPath(item?.sourceTagPath ?? []),
    );
  }

  // ==================================================================================

  Row buildHeader(BuildContext context) {
    DateTime? dateTime = item?.eventTime == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(item!.eventTime!);

    bool acknowledged = item?.acknowledged ?? false;

    return Row(
      children: [
        CircleAvatar(
          maxRadius: 10.sp,
          backgroundColor:
              getCriticalityColors(criticaliy: item?.criticality ?? ""),
          child: Text(
            item?.criticality?[0].toUpperCase() ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: acknowledged ? 0.4 : 1,
                child: Text(
                  item?.name ?? "",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                dateTime == null ? "N/A" : timeago.format(dateTime),
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          if (acknowledged) {
            return const SizedBox();
          }

          return ContainerWithTextWidget(
            bgColor: Theme.of(context).primaryColor,
            value: "Unacknowledged",
            // fgColor: kBlack,
            borderRadius: 8.sp,
          );
        }),
        SizedBox(
          width: 5.sp,
        ),
        ContainerWithTextWidget(
          bgColor: getStausofAlarm(
              active: item?.active ?? false,
              resolved: item?.resolved ?? false)['color'],
          value: getStausofAlarm(
              active: item?.active ?? false,
              resolved: item?.resolved ?? false)['text'],
          fgColor: kWhite,
          borderRadius: 5,
        ),
      ],
    );
  }
}
