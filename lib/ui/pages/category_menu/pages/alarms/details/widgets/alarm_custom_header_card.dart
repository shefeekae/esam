


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/models/list_alarms_model.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../functions/alarm_path.dart';

class AlarmCustomHeaderCard extends StatelessWidget {
  const AlarmCustomHeaderCard({
    super.key,
    required this.eventLogs,
  });

  final EventLogs eventLogs;

  @override
  Widget build(BuildContext context) {
    String formatedDate = eventLogs.eventTime == null
        ? "N/A"
        : DateFormat("MMM dd yyyy").add_jms().format(
            DateTime.fromMillisecondsSinceEpoch(eventLogs.eventTime ?? 0));

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventLogs.name ?? "",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Text(
            getAlarmsPath(
              eventLogs.sourceTagPath ?? [],
            ),
            style: TextStyle(
              color: ThemeServices().getLabelColor(context).withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Text("Alarm is generated at $formatedDate",)
        ],
      ),
    );
  }
}
