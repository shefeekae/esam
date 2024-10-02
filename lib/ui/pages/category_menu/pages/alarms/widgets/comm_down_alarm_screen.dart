import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/alarm_custom_header_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/diagnosis/alarm_diagnosis_widget.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/show_affected_equipments.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/buttons/normalize_alarm_buttons.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/services/alarms/alarms_details_services.dart';
import '../../equipments/list/equipments_list.dart';

class CommunicationDownAlarmScreen extends StatelessWidget {
  CommunicationDownAlarmScreen({required this.eventLogs, super.key});

  final EventLogs eventLogs;

  final UserDataSingleton userData = UserDataSingleton();

  @override
  Widget build(BuildContext context) {
    AlarmsDetailsServices().acknowledgeAlarm(
      context,
      eventId: eventLogs.eventId ?? "",
      isAcknowledged: eventLogs.acknowledged,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(eventLogs.name ?? ""),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.sp),
        child: ListView(
          children: [
            AlarmCustomHeaderCard(
              eventLogs: eventLogs,
            ),
            SizedBox(
              height: 10.sp,
            ),
            AlarmDiagnosisWidget(
              eventLogs: eventLogs,
            ),
            SizedBox(
              height: 20.sp,
            ),
            CustomElevatedButton(
              title: "Show Affected Equipments",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowAffectedEquipments(
                    payload: {
                      "path": [eventLogs.sourceId],
                    },
                    alarmName: eventLogs.name ?? "",
                  ),
                ));

                // Navigator.of(context)
                //     .pushNamed(EquipmentsListScreen.id, arguments: {
                //   "filterValues": [
                //     {
                //       "key": "clientDomain",
                //       "filterKey": "clients",
                //       "identifier": userData.domain,
                //       "values": [
                //         {
                //           "name": userData.domain,
                //           "data": userData.domain,
                //         }
                //       ]
                //     },
                //     {
                //       "key": "subCommunity",
                //       "filterKey": "path",
                //       "identifier": [eventLogs.sourceId],
                //       "values": [
                //         {
                //           "name": eventLogs.sourceName,
                //           "data": {
                //             "data": {
                //               "identifier": eventLogs.sourceId,
                //               "domain": eventLogs.sourceDomain,
                //             },
                //             "type": eventLogs.sourceType,
                //           },
                //         }
                //       ]
                //     },
                //     // {
                //     //   "key": "type",
                //     //   "filterKey": "type",
                //     //   "identifier": ["FAHU"],
                //     //   "values": [
                //     //     {
                //     //       "name": "FAHU",
                //     //       "data": "FAHU",
                //     //     }
                //     //   ]
                //     // }
                //   ]
                // });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.sp),
              child: NormalizeAlarmButton(
                eventId: eventLogs.eventId ?? "",
                isActive: eventLogs.active ?? false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
