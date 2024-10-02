import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/models/alarms/alarms_details_model.dart';
import '../../../../../../../core/models/list_alarms_model.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../widgets/alarm_header_card.dart';

class BuildAlarmHeaderCardWithLoading extends StatelessWidget {
  final bool isLoading;
  final AlarmDetailsModel? alarmDetailsModel;

  const BuildAlarmHeaderCardWithLoading({
    Key? key,
    required this.isLoading,
    required this.alarmDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (isLoading) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          decoration: BoxDecoration(
            color: ThemeServices().getBgColor(context),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Column(
            children: [
              ListTile(
                leading: CircleAvatar(),
                title: Text("Alarm Name"),
                subtitle: Text("time"),
                trailing: Text("data"),
              ),
            ],
          ),
        );
      }

      EventLogs eventLogs = EventLogs.fromJson(
        alarmDetailsModel?.getEventDetails?.event?.toJson() ?? {},
      );

      return AlarmHeaderCard(
        showChart: false,
        showCriticalPoints: false,
        item: eventLogs,
      );
    });
  }
}
