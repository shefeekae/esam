import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/list_alarms_model.dart';
import 'package:nectar_assets/core/services/alarms/alarms_details_services.dart';
import 'package:nectar_assets/core/services/alarms/alarms_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/details/widgets/alarm_custom_header_card.dart';
// ignore: unused_import
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/alarm_header_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/details/pages/equpment_live_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/equipments/list/equipments_list.dart';
import 'package:nectar_assets/ui/shared/functions/epoch_to_formated_date.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:nectar_assets/ui/shared/widgets/container/background_container.dart';
import 'package:nectar_assets/ui/shared/widgets/weather/weather_icon_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:video_tutorials/shared/functions/show_snackbar.dart';
import '../../../../../shared/widgets/weather/weather_list_view_builder.dart';
import '../details/widgets/diagnosis/alarm_diagnosis_widget.dart';
import '../show_affected_equipments.dart';

class WeatherForeCastAlarmScreen extends StatelessWidget {
  WeatherForeCastAlarmScreen({required this.eventLogs, super.key});

  final EventLogs eventLogs;

  final AlarmsServices alarmsServices = AlarmsServices();

  @override
  Widget build(BuildContext context) {
    List list = jsonDecode(eventLogs.suspectData ?? "[]");

    var pressureData =
        alarmsServices.getSuspectElement(list: list, pointName: "Pressure");

    var humidityData =
        alarmsServices.getSuspectElement(list: list, pointName: "Humidity");

    var windData =
        alarmsServices.getSuspectElement(list: list, pointName: "Wind");

    var weatherData =
        alarmsServices.getSuspectElement(list: list, pointName: "Weather Data");

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
            SizedBox(
              height: 15.sp,
            ),
            buildStatusCards(pressureData, humidityData, windData,
                suspectData: list),
            SizedBox(
              height: 15.sp,
            ),
            buildAlarmDiagnosis(context, weatherData?['data'] ?? ""),
            SizedBox(
              height: 20.sp,
            ),
            CustomElevatedButton(
              onPressed: () {
                showSnackBar(
                  context: context,
                  text: "Turned off fresh air handling units",
                );
              },
              title: "Turn Off FAHUS",
            ),
            SizedBox(
              height: 2.sp,
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowAffectedEquipments(
                    payload: {
                      "type": const ["FAHU"],
                      "path": [eventLogs.sourceId],
                    },
                    alarmName: eventLogs.name ?? "",
                  ),
                ));
              },
              title: "Show Affected Equipments",
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================================

  Widget buildAlarmDiagnosis(BuildContext context, String data) {
    return AlarmDiagnosisWidget(
      eventLogs: eventLogs,
      data: data,
    );
  }

  // ===========================================================================

  Widget buildStatusCards(
    pressureData,
    humidityData,
    windData, {
    required List suspectData,
  }) {
    String pressure =
        pressureData?['data'] != null ? "${pressureData['data']} hPa" : "N/A";

    String humidity =
        humidityData?['data'] != null ? "${humidityData['data']}%" : "N/A";
    String wind = windData?['data'] != null ? "${windData['data']} m/s" : "N/A";

    Map<String, dynamic>? temperatureData = alarmsServices.getSuspectElement(
        list: suspectData, pointName: "Temperature");

    Map<String, dynamic>? weatherIcon = alarmsServices.getSuspectElement(
        list: suspectData, pointName: "Weather Icon");

    Map<String, dynamic>? latData = alarmsServices.getSuspectElement(
        list: suspectData, pointName: "Latitude");

    Map<String, dynamic>? lngData = alarmsServices.getSuspectElement(
        list: suspectData, pointName: "Longitude");

    String formatedDateTime = epochTimeToFormatedTime(eventLogs.eventTime ?? -1,
        pattern: "EEEE, dd-MMM-yyyy hh:mm a");

    String activeMessage = eventLogs.activeMessage ?? "";

    return BgContainer(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statusCard(title: "Pressure", data: pressure),
              statusCard(title: "Humidity", data: humidity),
              statusCard(title: "Wind", data: wind),
            ],
          ),
          SizedBox(
            height: 15.sp,
          ),
          Row(
            children: [
              WeatherIconWidget(
                iconId: weatherIcon?["data"] ?? "",
              ),
              SizedBox(
                width: 10.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${temperatureData?['data'] ?? "0"} ℃",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    Text(formatedDateTime),
                    SizedBox(
                      height: 3.sp,
                    ),
                    Text(activeMessage)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.sp,
          ),
          WeatherListviewBuilder(
            lat: latData?['data'] ?? 0.0,
            lng: latData?['data'] ?? 0.0,
          ),
          SizedBox(
            height: 5.sp,
          ),
        ],
      ),
    );
  }

  // ==========================================================================================

  Widget statusCard({
    required String title,
    required String data,
  }) {
    return Builder(
        builder: (context) => Container(
              height: 50.sp,
              width: 29.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                        color: ThemeServices().getPrimaryFgColor(context),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                      child: Text(
                        data,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: ThemeServices().getPrimaryFgColor(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  // =========================================================================

  AppBar buildAppbar() {
    return AppBar(
      title: Text(eventLogs.name ?? "Weather Forecast Alarm"),
    );
  }
}
