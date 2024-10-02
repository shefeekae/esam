import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/schemas/alarms_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/alarm_custom_header_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/buttons/normalize_alarm_buttons.dart';
import 'package:nectar_assets/ui/shared/widgets/build_title_and_data.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:nectar_assets/ui/shared/widgets/loading_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/services/alarms/alarms_details_services.dart';
import '../show_affected_equipments.dart';

class SystemGeneratedAlarmScreen extends StatelessWidget {
  SystemGeneratedAlarmScreen({required this.eventLogs, super.key});

  final EventLogs eventLogs;

  final UserDataSingleton userData = UserDataSingleton();

  Map<String, dynamic> map = {
    "shortTermImpact": "Short Term Impact",
    "shortTermImpactValue":
        "Immediate impact on 3 phase equipments - Can undergo immediate failure.",
    "longTermImpact": "Long Term Impact",
    "longTermImpactValue1":
        "Reduced performance of connected equipments such as 3 phase pumps,fan motors, compressors.",
    "longTermImpactValue2": "Increased motor winding temperatures.",
    "longTermImpactValue3": "Increased maintenance cycles.",
    "immediateAction": "Immediate Action",
    "immediateActionValue":
        "If possible switch off connected equipment and/or breakers.",
    "otherActions": "Other actions",
    "otherActionsValue1":
        "Check performance of current Transducers of the Meters and recalibrate.",
    "otherActionsValue2": "Breaker inspection and replacement.",
  };

  @override
  Widget build(BuildContext context) {
    AlarmsDetailsServices().acknowledgeAlarm(
      context,
      eventId: eventLogs.eventId ?? "",
      isAcknowledged: eventLogs.acknowledged,
    );

    return Scaffold(
      appBar: buildAppbar(),
      body: Padding(
        padding: EdgeInsets.all(5.sp),
        child: ListView(
          children: [
            AlarmCustomHeaderCard(
              eventLogs: eventLogs,
            ),
            buildSystemGeneratedAlarmData(context),
            SizedBox(
              height: 20.sp,
            ),
            CustomElevatedButton(
              title: "Show Affected Equipments",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowAffectedEquipments(
                    payload: {
                      "type": eventLogs.sourceType,
                      "data": {
                        "domain": eventLogs.sourceDomain,
                        "identifier": eventLogs.sourceId,
                      },
                    },
                    alarmName: eventLogs.name ?? "",
                  ),
                ));
              },
            ),
            NormalizeAlarmButton(
              padding: EdgeInsets.only(top: 5.sp),
              eventId: eventLogs.eventId ?? "",
              isActive: eventLogs.active ?? false,
            )
          ],
        ),
      ),
    );
  }

  // ===================================================

  QueryWidget buildSystemGeneratedAlarmData(BuildContext context) {
    return QueryWidget(
      options: GraphqlServices().getQueryOptions(
          query: AlarmsSchema.getSystemGeneratedAlarmData,
          variables: {
            "brand": userData.domain,
          }),
      builder: (result, {fetchMore, refetch}) {
        List list = result.data?['getSystemGeneratedAlarmData']['data'] ?? [];

        if (result.hasException) {
          return const SizedBox();
        }

        if (list.isEmpty) {
          return const SizedBox();
        }

        return Container(
          padding: EdgeInsets.all(7.sp),
          margin: EdgeInsets.only(top: 10.sp),
          decoration: BoxDecoration(
            color: ThemeServices().getBgColor(context),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              list.length,
              (index) {
                String title = "";
                List values = [];

                try {
                  title = map[list[index]['key'].toString().split('.').last];
                  values = list[index]['data'].map((e) {
                    return map[e.toString().split('.').last].toString();
                  }).toList();
                } catch (_) {}

                return BuildTitleAndData(
                  title: title,
                  values: values,
                );
              },
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: Text(eventLogs.name ?? "Weather Forecast Alarm"),
    );
  }
}
