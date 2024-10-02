import 'package:flutter/material.dart';
import 'package:graphql_config/widget/query_widget.dart';
import 'package:nectar_assets/core/services/alarms/alarms_details_services.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../core/models/list_alarms_model.dart';
import '../../../../../../../../core/schemas/alarms_schema.dart';
import '../../../../../../../../core/services/graphql_services.dart';
import '../../../../../../../../core/services/theme/theme_services.dart';

class AlarmDiagnosisWidget extends StatelessWidget {
  const AlarmDiagnosisWidget({
    super.key,
    required this.eventLogs,
    this.data = "",
  });

  final EventLogs eventLogs;
  final String data;

  @override
  Widget build(BuildContext context) {
    AlarmsDetailsServices().acknowledgeAlarm(
      context,
      eventId: eventLogs.eventId ?? "",
      isAcknowledged: eventLogs.acknowledged ?? false,
    );

    return QueryWidget(
      options: GraphqlServices()
          .getQueryOptions(query: AlarmsSchema.getAlarmDiagnosis, variables: {
        "data": {
          "eventId": eventLogs.eventId,
          "name": eventLogs.name,
          "sourceId": eventLogs.sourceId,
        }
      }),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const SizedBox();
        }

        String suggestion = "";

        try {
          suggestion = result.data?['getAlarmDiagnosis']?['suggestion'] ?? "";
          // ignore: empty_catches
        } catch (e) {
          return Container(
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              color: ThemeServices().getBgColor(context),
              borderRadius: BorderRadius.circular(5),
            ),
            child:
                Text(data.isEmpty ? "Diagnosis data is not available" : data),
          );
        }

        return Builder(builder: (context) {
          return Container(
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              color: ThemeServices().getBgColor(context),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: data.isNotEmpty,
                  child: Column(
                    children: [
                      Text(data),
                      SizedBox(
                        height: 7.sp,
                      ),
                    ],
                  ),
                ),
                Text(suggestion),
              ],
            ),
          );
        });
      },
    );
  }
}
