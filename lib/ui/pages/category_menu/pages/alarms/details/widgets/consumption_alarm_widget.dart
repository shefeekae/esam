import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/alarms/alarms_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/alarm_data_trend_chart.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../../core/models/alarms/alarms_details_model.dart';
import '../../../../../../../core/models/list_alarms_model.dart';
import '../../widgets/buttons/normalize_alarm_buttons.dart';
import 'alarm_custom_header_card.dart';
import 'chart/consumption_comparison_chart.dart';

class ConsumptionAlarmWidget extends StatelessWidget {
  ConsumptionAlarmWidget({
    super.key,
    required this.event,
  });

  final Event? event;

  final AlarmsServices alarmsServices = AlarmsServices();

  @override
  Widget build(BuildContext context) {
    EventLogs eventLogs = EventLogs.fromJson(
      event?.toJson() ?? {},
    );

    String description = eventLogs.activeMessage ?? "";

    List suspectDataList =
        alarmsServices.getSuspectDataList(eventLogs.suspectData);

    return ListView(
      children: [
        AlarmCustomHeaderCard(
          eventLogs: eventLogs,
        ),
        buildContainerWithListTiles(
          context,
          description,
          suspectDataList,
        ),
        buildConsumption(suspectDataList, eventLogs),
        buildNormalizebutton(),
      ],
    );
  }
  // ====================================================================
  // Normalize Alarm Button

  Widget buildNormalizebutton() {
    return NormalizeAlarmButton(
      padding: EdgeInsets.only(top: 10.sp),
      eventId: event?.eventId ?? "",
      isActive: event?.active ?? false,
    );
  }

  // ===========================================================================

  Builder buildConsumption(List<dynamic> suspectDataList, EventLogs eventLogs) {
    return Builder(builder: (context) {
      Map<String, dynamic>? dataTypeData = alarmsServices.getSuspectElement(
        list: suspectDataList,
        pointName: "dataType",
      );

      List suspectData = jsonDecode(event?.suspectData ?? "[]");

      List pointNames = suspectData.map((e) => e["pointName"]).toList();

      if (dataTypeData == null) {
        return const SizedBox();
      }

      bool isConsumption = dataTypeData['data'] == "Consumption";

      if (!isConsumption) {
        bool isReadingOrMeter =
            dataTypeData['data'] == "Reading" || dataTypeData['Meter'];

        if (isReadingOrMeter) {
          return Padding(
            padding: EdgeInsets.only(top: 10.sp),
            child: BgContainer(
              child: EquipmentDataTrendsChart(
                sourceId: event?.sourceId ?? "",
                sourceType: event?.sourceType ?? "",
                sourceDomain: event?.sourceDomain ?? "",
                pointNames: pointNames,
              ),
            ),
          );
        }

        return const SizedBox();
      }

      Map<String, dynamic>? currentTimeData = alarmsServices.getSuspectElement(
          list: suspectDataList, pointName: "Current Time");

      if (currentTimeData == null) {
        return const SizedBox();
      }

      Map<String, dynamic>? durationData = alarmsServices.getSuspectElement(
        list: suspectDataList,
        pointName: "Duration",
      );

      Map<String, dynamic>? previousTimeData = alarmsServices.getSuspectElement(
        list: suspectDataList,
        pointName: "Previous Time",
      );

      int startDate = currentTimeData['data'] ?? 0;
      int previousDate = previousTimeData?['data'] ?? 0;
      int? durationDays = durationData?['data'];

      DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startDate);

      startDateTime =
          DateTime(startDateTime.year, startDateTime.month, startDateTime.day);

      DateTime previousDateTime =
          DateTime.fromMillisecondsSinceEpoch(previousDate);

      int endDate = startDateTime
          .add(Duration(
            days: durationDays ?? 0,
          ))
          .subtract(const Duration(seconds: 1))
          .millisecondsSinceEpoch;

      return Padding(
        padding: EdgeInsets.only(top: 10.sp),
        child: HighConsumptionBarChart(
          equipmentEntity: {
            "type": eventLogs.sourceType,
            "data": {
              "identifier": eventLogs.sourceId,
              "domain": eventLogs.sourceDomain
            }
          },
          startDate: startDateTime.millisecondsSinceEpoch,
          endDate: endDate,
          utilityType: eventLogs.sourceType ?? "",
          comparePeriod: previousDateTime.year,
        ),
      );
    });
  }

  // ============================================================================================

  Widget buildContainerWithListTiles(
    BuildContext context,
    String description,
    List<dynamic> suspectDataList,
  ) {
    if (suspectDataList.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          buildListTitle(
            context,
            title: "Description",
            data: description,
          ),
          buildListTitle(
            context,
            title: "Current Data",
            data: alarmsServices.getSuspectElementDataWithUnit(
              suspectDataList: suspectDataList,
              pointName: "Current Data",
            ),
          ),
          buildListTitle(
            context,
            title: "Previous Data",
            data: alarmsServices.getSuspectElementDataWithUnit(
              suspectDataList: suspectDataList,
              pointName: "Previous Data",
            ),
          ),
          buildListTitle(
            context,
            title: "Variance",
            data: alarmsServices.getSuspectElementDataWithUnit(
              suspectDataList: suspectDataList,
              pointName: "Variance",
            ),
          ),
          buildListTitle(
            context,
            title: "Last Communicated Time",
            data: alarmsServices.getSuspectElementDataWithUnit(
              suspectDataList: suspectDataList,
              pointName: "Last Communicated Time",
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================

  Widget buildListTitle(
    BuildContext context, {
    required String title,
    required String data,
  }) {
    if (data.isEmpty) {
      return const SizedBox();
    }

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 10.sp,
        ),
      ),
      trailing: ConstrainedBox(
        constraints: BoxConstraints.loose(Size.fromWidth(65.w)),
        child: Text(
          data,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
