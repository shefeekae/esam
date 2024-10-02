import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/comm_down_alarm_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/system_generated_screen.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/widgets/weather_forecast_alarm_screen.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../core/models/list_alarms_model.dart';
import '../../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../shared/widgets/textfield/image_with_textfield.dart';
import '../../details/alarms_details.dart';
import '../../widgets/alarm_header_card.dart';
import 'comments/alarm_comment_button.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    required this.item,
    required this.showchart,
    required this.pagingController,
    this.showComments = true,
    super.key,
  });

  final EventLogs item;
  final bool showchart;
  final bool showComments;
  final PagingController<int, EventLogs> pagingController;

  @override
  Widget build(BuildContext context) {
    String? group = item.group;
    String? type = item.type;

    return GestureDetector(
      onTap: () async {
        bool hasPermission = UserPermissionServices().checkingPermission(
          featureGroup: "alarmManagement",
          feature: "list",
          permission: "view",
        );

        if (!hasPermission) {
          return;
        }

        bool isPredectiveOrPreventive =
            group == "PREDICTIVE" || group == "PREVENTIVE";

        // Checking the  alarm detail api call success or not. eg: normalize alarm
        bool? success;

        if (isPredectiveOrPreventive && type == "WEATHER_FORECAST") {
          success = await Navigator.of(context).push<dynamic>(MaterialPageRoute(
            builder: (context) => WeatherForeCastAlarmScreen(
              eventLogs: item,
            ),
          ));
        } else if (isPredectiveOrPreventive && type == "COMM_DOWN") {
          success = await Navigator.of(context).push<dynamic>(MaterialPageRoute(
            builder: (context) => CommunicationDownAlarmScreen(
              eventLogs: item,
            ),
          ));
        } else if (isPredectiveOrPreventive && type == "SYSTEM_GENERATED") {
          success = await Navigator.of(context).push<dynamic>(MaterialPageRoute(
            builder: (context) => SystemGeneratedAlarmScreen(
              eventLogs: item,
            ),
          ));
        } else {
          success = await Navigator.of(context).pushNamed<dynamic>(
            AlarmsDetailsScreen.id,
            arguments: {
              "identifier": item.eventId,
            },
          );
        }
        success ??= false;

        if (success) {
          pagingController.refresh();
        }
      },
      child: Container(
        color: ThemeServices().getBgColor(context),
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Column(
          children: [
            AlarmHeaderCard(
              item: item,
              showChart: showchart,
            ),
            PermissionChecking(
              featureGroup: "alarmManagement",
              feature: "list",
              permission: "Comment",
              child: Visibility(
                visible: showComments,
                child: Column(
                  children: [
                    const Divider(
                      height: 0,
                    ),
                    AlarmCommentButtonWidget(
                      eventId: item.eventId ?? "",
                    ),
                    const Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    BuildImageWithTextfield(
                      eventId: item.eventId ?? "",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
