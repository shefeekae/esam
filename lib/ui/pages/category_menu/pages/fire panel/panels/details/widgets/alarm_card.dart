import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/alarms_details.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/functions/alarm_path.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/fire%20panel/panels/details/functions/show_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PanelAlarmCard extends StatelessWidget {
  const PanelAlarmCard({
    super.key,
    required this.eventLog,
  });

  final EventLogs eventLog;
  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = eventLog.eventTime == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(eventLog.eventTime!);

    List<dynamic> suspectData = jsonDecode(eventLog.suspectData!);

    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(
          AlarmsDetailsScreen.id,
          arguments: {
            "identifier": eventLog.eventId,
          },
        );
      },
      child: Container(
          padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(color: ThemeServices().getBgColor(context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      eventLog.name ?? "",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    dateTime == null ? "N/A" : timeago.format(dateTime),
                    style: TextStyle(fontSize: 8.sp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconHelpers()
                      .showAlarmLeadingIcon(suspectData[0]["pointName"] ?? ""),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 10.sp,
                  ),
                  Expanded(
                    child: Text(
                      getShortAlarmPath(eventLog.sourceTagPath ?? []),
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
