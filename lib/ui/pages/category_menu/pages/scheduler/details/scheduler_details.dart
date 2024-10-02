// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_details_model.dart';
import 'package:nectar_assets/core/schemas/scheduler_shemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/scheduler/sheduler_calendar_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/details/widgets/scheduler_details_container.dart';
import 'package:nectar_assets/ui/shared/widgets/permission/permission_checking_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../../../core/services/theme/theme_services.dart';
import 'widgets/scheduler_equipment_points_actions_tiles.dart';

class SchedulerDetailsScreen extends StatelessWidget {
  SchedulerDetailsScreen({super.key});

  static const String id = '/scheduler/details';

  final SizedBox sizedBox = SizedBox(
    height: 10.sp,
  );

  final ValueNotifier<String> nameNotifier = ValueNotifier<String>("");

  updateName(String value) async {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      nameNotifier.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
            valueListenable: nameNotifier,
            builder: (context, value, _) {
              return Text(value.isEmpty ? "Scheduler Details" : value);
            }),
      ),
      body: PermissionChecking(
        featureGroup: "scheduler",
        feature: "scheduler",
        permission: "view",
        showNoAccessWidget: true,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: QueryWidget(
            options: GraphqlServices().getQueryOptions(
                query: SchedulerSchema.findSchedule,
                variables: {
                  "id": args?['id'],
                }),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return Skeletonizer(
                  child: Column(
                    children: [
                      const SchedulerDetailsContainer(
                          iconData: Icons.date_range,
                          firstLabel: "Start Date",
                          firstValue: "Loading....",
                          secondLabel: "End Date",
                          secondValue: "Loadingg"),
                      sizedBox,
                      const SchedulerDetailsContainer(
                        iconData: Icons.access_time,
                        firstLabel: "Start Time",
                        firstValue: "Loading",
                        secondLabel: "End Time",
                        secondValue: "Loading",
                      ),
                      sizedBox,
                      const SchedulerDetailsContainer(
                        iconData: Icons.update,
                        firstLabel: "Repeats:",
                        firstValue: "Loadingg",
                        secondLabel: "Intervel",
                        secondValue: "Loading..",
                      ),
                    ],
                  ),
                );
              }

              if (result.hasException) {
                return GrapghQlClientServices().handlingGraphqlExceptions(
                  result: result,
                  context: context,
                  refetch: refetch,
                );
              }

              SchedulerDetails schedulerDetails =
                  SchedulerDetails.fromJson(result.data ?? {});

              DateTime startDay = DateTime.fromMillisecondsSinceEpoch(
                  schedulerDetails.findSchedule?.startDay ?? 0);

              DateTime endDay = DateTime.fromMillisecondsSinceEpoch(
                  schedulerDetails.findSchedule?.endDay ?? 0);

              FindSchedule? findSchedule = schedulerDetails.findSchedule;

              updateName(schedulerDetails.findSchedule?.name ?? '');

              List<Source> equipments =
                  schedulerDetails.findSchedule?.source ?? [];

              return ListView(
                children: [
                  SchedulerDetailsContainer(
                      iconData: Icons.date_range,
                      firstLabel: "Start Date",
                      firstValue: DateFormat("MMM dd yyyy").format(startDay),
                      secondLabel: "End Date",
                      secondValue: DateFormat("MMM dd yyyy").format(endDay)),
                  sizedBox,
                  SchedulerDetailsContainer(
                    iconData: Icons.access_time,
                    firstLabel: "Start Time",
                    firstValue: DateFormat().add_jm().format(startDay),
                    secondLabel: "End Time",
                    secondValue: DateFormat().add_jm().format(endDay),
                  ),
                  Builder(
                    builder: (context) {
                      bool isRecurring = findSchedule?.recurring ?? false;
                      String? rRule = findSchedule?.rrule;

                      if (!isRecurring || rRule == null) {
                        return const SizedBox();
                      }

                      RecurrenceProperties recurrenceProperties =
                          SfCalendar.parseRRule(rRule, startDay);

                      int intervel = recurrenceProperties.interval;

                      var weekdaysValues =
                          SchedulerCalendarServices().weekDaysValueMap;

                      RecurrenceType recurrenceType =
                          recurrenceProperties.recurrenceType;

                      return Column(
                        children: [
                          sizedBox,
                          SchedulerDetailsContainer(
                            iconData: Icons.update,
                            firstLabel: "Repeats:",
                            firstValue: SchedulerCalendarServices()
                                .getSchedulerRepeatsType(
                              recurrenceProperties.recurrenceType,
                            ),
                            secondLabel: "Intervel",
                            secondValue: "$intervel day(s)",
                          ),
                          buildWeekDayswidget(recurrenceType, context,
                              weekdaysValues, recurrenceProperties)
                        ],
                      );
                    },
                  ),
                  sizedBox,
                  SchedulerEquipmentPointActionsTiles(
                    equipments: equipments,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ===================================================================================

  Visibility buildWeekDayswidget(
    RecurrenceType recurrenceType,
    BuildContext context,
    Map<dynamic, String> weekdaysValues,
    RecurrenceProperties recurrenceProperties,
  ) {
    return Visibility(
      visible: recurrenceType == RecurrenceType.weekly,
      child: Column(
        children: [
          sizedBox,
          Container(
            padding: EdgeInsets.all(10.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ThemeServices().getBgColor(context),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Wrap(
                children: List.generate(
              weekdaysValues.length,
              (index) {
                String title = weekdaysValues.values.elementAt(index);

                bool enabled = recurrenceProperties.weekDays.any((element) =>
                    element == weekdaysValues.keys.elementAt(index));

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: enabled,
                      onChanged: (value) {},
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: ThemeServices().getBgColor(context),
                    ),
                    Text(title),
                  ],
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
