import 'package:flutter/material.dart';
import 'package:nectar_assets/core/enums/dashboards_enum.dart';
import 'package:nectar_assets/core/models/insights/insights_dropdown_model.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/active_alarm_aging_distibution_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/alarm_lifetime_distribution_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/alarm_status_card.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/all_alarms_criticality_distribution.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/all_alarms_daily_distribution_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/all_alarms_space_distribution_pichart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/equipment_types_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/top_5_alarm_categories_chart.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/dashboards/screens/alarm/widgets/top_5_occuring_names_chart.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/date_range_button.dart';
import 'package:nectar_assets/ui/shared/widgets/dropdown/level_dropdown_widget.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';

class AlarmDashboard extends StatefulWidget {
  const AlarmDashboard({
    super.key,
    required this.dropdownType,
    this.dropDownData,
    this.initialDateTimeRange,
    this.communityDomain,
    this.parentEntity,
  });

  final Level dropdownType;

  final DateTimeRange? initialDateTimeRange;
  final String? communityDomain;
  final Map<String, dynamic>? parentEntity;

  final CommunityHierarchyDropdownData? dropDownData;

  @override
  State<AlarmDashboard> createState() => _AlarmDashboardState();
}

class _AlarmDashboardState extends State<AlarmDashboard> {
  DateTime now = DateTime.now();

  late ValueNotifier<DateTimeRange> dateTimeRangeNotifier;

  UserDataSingleton userData = UserDataSingleton();

  late ValueNotifier<CommunityHierarchyDropdownData?> dropDownValueNotifier;

  @override
  void initState() {
    DateTime startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 8));

    DateTime endOfWeek = DateTime(now.year, now.month, now.day, 23, 59, 59);

    dateTimeRangeNotifier = ValueNotifier(widget.initialDateTimeRange ??
        DateTimeRange(start: startOfWeek, end: endOfWeek));

    dropDownValueNotifier = ValueNotifier(widget.dropDownData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LevelDropdownWidget(
            title: "Alarm Dashboard",
            level: widget.dropdownType,
            communityDomain: widget.communityDomain,
            parentEntity: widget.parentEntity,
            dropDownValueNotifier: dropDownValueNotifier),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DateRangePickerButton(
                    initialDateTimeRange: dateTimeRangeNotifier.value,
                    onChanged: (dateTimeRange) {
                      dateTimeRangeNotifier.value = dateTimeRange;
                    },
                  )
                ],
              ),
              SizedBox(
                height: 8.sp,
              ),
              ValueListenableBuilder(
                  valueListenable: dropDownValueNotifier,
                  builder: (context, value, child) {
                    return AlarmStatusCard(
                      startDate: dateTimeRangeNotifier
                          .value.start.millisecondsSinceEpoch,
                      endDate: dateTimeRangeNotifier
                          .value.end.millisecondsSinceEpoch,
                      entity: dropDownValueNotifier.value?.entity,
                    );
                  }),
            ],
          ),
        ),
        // actions: const [Flexible(child: AlarmExportPopmenuButton())],
      ),
      body: PermissionChecking(
        featureGroup: "dashboard",
        feature: "alarm",
        permission: "view",
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: ValueListenableBuilder(
            valueListenable: dropDownValueNotifier,
            builder: (context, value, child) {
              return ValueListenableBuilder(
                  valueListenable: dateTimeRangeNotifier,
                  builder: (context, value, child) {
                    return ListView(
                      children: [
                        AlarmLifetimeDistributionWidget(
                          dropdownType: widget.dropdownType,
                          identifier: dropDownValueNotifier.value?.identifier,
                          entity: dropDownValueNotifier.value?.entity,
                        ),
                        ActiveAlarmsAgingDistributionWidget(
                          dropdownType: widget.dropdownType,
                          identifier: dropDownValueNotifier.value?.identifier,
                          entity: dropDownValueNotifier.value?.entity,
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                        ),
                        AllAlarmsCriticalityDistribution(
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                          entity: dropDownValueNotifier.value?.entity,
                          dropdownType: widget.dropdownType,
                        ),
                        AllAlarmsDailyDistributionWidget(
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                          entity: dropDownValueNotifier.value?.entity,
                          dropdownType: widget.dropdownType,
                        ),
                        AllAlarmsSpaceDistributionChart(
                          entity: dropDownValueNotifier.value?.entity,
                          dropdownType: widget.dropdownType,
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                        ),
                        EquipmentTypesChartWidget(
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                          entity: dropDownValueNotifier.value?.entity,
                          dropdownType: widget.dropdownType,
                        ),
                        Top5OccuringNamesChart(
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                          entity: dropDownValueNotifier.value?.entity,
                          dropdownType: widget.dropdownType,
                        ),
                        Top5AlarmCategoriesChart(
                          startDate: value.start.millisecondsSinceEpoch,
                          endDate: value.end.millisecondsSinceEpoch,
                          entity: dropDownValueNotifier.value?.entity,
                          dropdownType: widget.dropdownType,
                        ),
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
