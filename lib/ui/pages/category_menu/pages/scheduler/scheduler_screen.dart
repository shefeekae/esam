import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar_assets/core/services/permissions/user_permission_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/list/enum/scheduler_view_enums.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/search/scheduler_list_search_delgate.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/calendar/scheduler_calendar.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/list/scheduler_list.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';


class SchedulerScreen extends StatelessWidget {
  SchedulerScreen({super.key});

  static const String id = '/scheduler/screen';

  final ValueNotifier<SchedulerView> schedulerViewNotifier =
      ValueNotifier<SchedulerView>(SchedulerView.calendarView);

  final bool hasPermission = UserPermissionServices().checkingPermission(
      featureGroup: "scheduler", feature: "scheduler", permission: "list");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: PermissionChecking(
        featureGroup: "scheduler",
        feature: "scheduler",
        permission: "list",
        showNoAccessWidget: true,
        child: ValueListenableBuilder(
          valueListenable: schedulerViewNotifier,
          builder: (context, value, _) {
            if (value == SchedulerView.calendarView) {
              return const SchedulerCalendar();
            }

            return const SchedulerList();
          },
        ),
      ),
    );
  }

  // ===================================================================================

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text("Schedules"),
      actions: [
        Visibility(
          visible: hasPermission,
          child: IconButton(
            onPressed: () {
              schedulerViewNotifier.value =
                  SchedulerView.calendarView == schedulerViewNotifier.value
                      ? SchedulerView.listView
                      : SchedulerView.calendarView;
            },
            icon: ValueListenableBuilder(
              valueListenable: schedulerViewNotifier,
              builder: (context, value, child) => Icon(
                value == SchedulerView.calendarView
                    ? Icons.list_alt
                    : Icons.calendar_month,
              ),
            ),
          ),
        ),
        Visibility(
          visible: hasPermission,
          child: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SchedulesSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
