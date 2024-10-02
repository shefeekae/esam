import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_config/widget/mutation_widget.dart';
import 'package:nectar_assets/core/models/alarms/alarms_details_model.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/alarm_custom_header_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/diagnosis/alarm_diagnosis_widget.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/show_all_recurring_alarms.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/buttons/normalize_alarm_buttons.dart';
import 'package:nectar_assets/ui/shared/functions/converters.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/custom_snackbar.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../shared/functions/duration_format.dart';
import 'package:timeago/timeago.dart';

class RecurringAlarmWidget extends StatelessWidget {
  RecurringAlarmWidget({
    super.key,
    required this.isLoading,
    this.alarmDetailsModel,
  });

  final bool isLoading;

  final AlarmDetailsModel? alarmDetailsModel;

  final SizedBox sizedBox = SizedBox(
    height: 10.sp,
  );

  final List<Map<String, String>> workOrdersList = [];

  @override
  Widget build(BuildContext context) {
    Event? event = alarmDetailsModel?.getEventDetails?.event;

    List sourceTagPath = jsonDecode(
        alarmDetailsModel?.getEventDetails?.event?.suspectData ?? "[]");

    sourceTagPath = sourceTagPath.where((element) {
      return element['pointName'] != "UnAcknowledged" &&
          element['pointName'] != "Acknowledged";
    }).toList();

    return ListView(
      children: [
        AlarmCustomHeaderCard(
          eventLogs: EventLogs.fromJson(
            alarmDetailsModel?.getEventDetails?.event?.toJson() ?? {},
          ),
        ),
        sizedBox,
        buildStatusCards(sourceTagPath, context),
        sizedBox,
        buildWorkOrders(),
        sizedBox,
        AlarmDiagnosisWidget(
          eventLogs: EventLogs.fromJson(
            event?.toJson() ?? {},
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        buildTemporaryDisabledButton(event),
        sizedBox,
        buildShowAllAlarmsbutton(context, event),
        NormalizeAlarmButton(
          padding: EdgeInsets.only(top: 10.sp),
          eventId: event?.eventId ?? "",
          isActive: event?.active ?? false,
        )
      ],
    );
  }

  // =======================================================================================

  Widget buildShowAllAlarmsbutton(BuildContext context, Event? event) {
    return CustomElevatedButton(
      title: "Show All Alarms",
      onPressed: () {
        Map<String, dynamic> assetEntity = {
          "type": event?.sourceType,
          "data": {
            "domain": event?.sourceDomain,
            "identifier": event?.sourceId,
            "name": event?.sourceName
          }
        };

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShowAllRecurringAlarms(
            alarmName: event?.name ?? "",
            payload: {
              "assets": assetEntity,
            },
          ),
        ));

        // Navigator.of(context).pushNamed(
        //   AlarmsListScreen.id,
        //   arguments: {
        //     "filterValues": [
        //       {
        //         "key": "assets",
        //         "filterKey": "assets",
        //         "data": [assetEntity],
        //         "values": [
        //           {
        //             "name": event?.sourceName,
        //             "identifier": assetEntity,
        //           }
        //         ]
        //       },
        //     ]
        //   },
        // );
      },
    );
  }

  // ====================================================================================

  Widget buildTemporaryDisabledButton(Event? event) {
    return Builder(
        builder: (context) => MutationWidget(
              options: GrapghQlClientServices().getMutateOptions(
                document: AlarmsSchema.temporarilyDisableEvent,
                context: context,
                onCompleted: (data) {
                  if (data != null) {
                    buildSnackBar(
                      context: context,
                      value: "Alarm Temporarily disabled",
                    );
                  }
                },
              ),
              builder: (runMutation, result) {
                return CustomElevatedButton(
                  isLoading: result?.isLoading ?? false,
                  title: "Temporarily Disable",
                  onPressed: () {
                    runMutation({
                      "data": {
                        "source": {
                          "type": event?.sourceType,
                          "data": {
                            "domain": event?.sourceDomain,
                            "identifier": event?.sourceId,
                          }
                        },
                        "name": "Setpoint out of Global Range"
                      }
                    });
                  },
                );
              },
            ));
  }

  // =========================================================================

  Widget buildWorkOrders() {
    return Visibility(
      visible: workOrdersList.isNotEmpty,
      child: BgContainer(
        padding: EdgeInsets.all(5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Associated Work Orders",
              style: TextStyle(
                fontSize: 10.sp,
              ),
            ),
            SizedBox(
              height: 2.sp,
            ),
            Wrap(
              spacing: 5.sp,
              children: List.generate(
                workOrdersList.length,
                (index) {
                  return Chip(
                    label: Text("#${workOrdersList[index]['number']}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // ========================================================================

  Wrap buildStatusCards(List<dynamic> sourceTagPath, BuildContext context) {
    return Wrap(
      // runAlignment: WrapAlignment.center,
      // crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      spacing: 10.sp,
      runSpacing: 10.sp,
      direction: Axis.horizontal,
      // alignment: WrapAlignment.spaceBetween,
      // crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(
        sourceTagPath.length,
        (index) {
          Map<String, dynamic> map = sourceTagPath[index];

          String name = map['pointName'] ?? "";
          String data = "";
          // map['data'].toString();

          if (name == "Average Duration") {
            int? milliseconds = map['data'] ?? 0;

            data = formatDuration(Duration(milliseconds: milliseconds ?? 0));
          } else if (name == "First Reported Time" ||
              name == "Last Reported Time") {
            data =
                format(Converter().convertDoubleToDateTime(map['data'] ?? 0));
          } else if (name == "Work Orders Generated") {
            List<String> pairs = map['data'].toString().split(';');
            for (String pair in pairs) {
              List<String> parts = pair.split(':');
              if (parts.length == 2) {
                workOrdersList.add({
                  "id": parts[0],
                  "number": parts[1],
                });
              }
            }

            data = workOrdersList.length.toString();
          } else {
            data = map['data'].toString();
          }

          return Container(
            height: 80.sp,
            width: 28.w,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: ThemeServices().getPrimaryFgColor(context),
                    ),
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  SizedBox(
                    height: 40.sp,
                    child: Text(
                      data,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: ThemeServices().getPrimaryFgColor(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
