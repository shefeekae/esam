import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:nectar_assets/core/models/custom_row_button_model.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_calendar_model.dart';
import 'package:nectar_assets/core/schemas/scheduler_shemas.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/scheduler/sheduler_calendar_services.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/scheduler/details/scheduler_details.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_row_buttons.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../../../core/services/scheduler/scheduler_calendar_data_source.dart';

class SchedulerCalendar extends StatefulWidget {
  const SchedulerCalendar({super.key});

  @override
  State<SchedulerCalendar> createState() => _SchedulerCalendarState();
}

class _SchedulerCalendarState extends State<SchedulerCalendar> {
  final ValueNotifier<CalendarView> toggleValueNotifier =
      ValueNotifier<CalendarView>(CalendarView.month);

  final CalendarController calendarController = CalendarController();

  final UserDataSingleton userData = UserDataSingleton();

  bool calendarInitialCalled = false;

  late final ValueNotifier<Map<String, int>> calendarDateNotifier;

  @override
  void initState() {
    DateTime now = DateTime.now();

    DateTime startDate = DateTime(now.year, now.month, 1);

    DateTime endDate = DateTime(now.year, now.month + 1, 0);

    calendarDateNotifier = ValueNotifier<Map<String, int>>({
      "startDate": startDate.millisecondsSinceEpoch,
      "endDate": endDate.millisecondsSinceEpoch,
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, int>>(
        valueListenable: calendarDateNotifier,
        builder: (context, value, _) {
          int startDate = value['startDate'] ?? 0;
          int endDate = value['endDate'] ?? 0;

          return QueryWidget(
            options: GrapghQlClientServices().getQueryOptions(
                document: SchedulerSchema.getSchedulerList,
                variables: {
                  "data": {
                    "clientId": [
                      userData.domain,
                    ],
                    "startDate": startDate,
                    "endDate": endDate,
                    "includeStatus": ["ACTIVE", "INACTIVE"]
                  }
                }),
            builder: (result, {fetchMore, refetch}) {
              if (result.hasException) {
                return GraphqlServices().handlingGraphqlExceptions(
                  result: result,
                  context: context,
                  refetch: refetch,
                );
              }

              SchedulerModel schedulerModel =
                  SchedulerModel.fromJson(result.data ?? {});

              return Column(
                children: [
                  Center(
                    child: Builder(builder: (context) {
                      if (result.isLoading) {
                        return AbsorbPointer(
                          child: Opacity(
                            opacity: 0.5,
                            child: buidToggleButtons(),
                          ),
                        );
                      }

                      return buidToggleButtons();
                    }),
                  ),
                  Expanded(
                    child: buldCalendar(
                      schedulers: schedulerModel.getSchedulerList ?? [],
                      context: context,
                      isLoading: result.isLoading,
                    ),
                  ),
                  // Text("data"),
                ],
              );
            },
          );
        });
  }

  // ==============================================================================================
  Widget buldCalendar({
    required List<SchedulerItem> schedulers,
    required BuildContext context,
    required bool isLoading,
  }) {
    if (isLoading) {
      return AbsorbPointer(
        child: Stack(
          children: [
            Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: SfCalendar(
                view: CalendarView.month,
                controller: calendarController,
                monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                ),
              ),
            )
          ],
        ),
      );
    }

    return SfCalendar(
      controller: calendarController,
      dataSource: SchedulerDataSource(
        SchedulerCalendarServices().getSchedulerCalendarDataSource(
          context: context,
          schedulerList: schedulers,
        ),
      ),
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(
        showAgenda: true,
      ),
      onTap: (calendarTapDetails) {
        if (calendarTapDetails.targetElement == CalendarElement.appointment) {
          Scheduler scheduler =
              calendarTapDetails.appointments!.first as Scheduler;

          Navigator.of(context)
              .pushNamed(SchedulerDetailsScreen.id, arguments: {
            "id": scheduler.id,
          });
        }
      },
      onViewChanged: (viewChangedDetails) {
        if (!calendarInitialCalled) {
          calendarInitialCalled = true;
          return;
        }

        var map = calendarDateNotifier.value;

        DateTime selectedStartDate =
            DateTime.fromMillisecondsSinceEpoch(map['startDate'] ?? 0);
        DateTime selectedEndDate =
            DateTime.fromMillisecondsSinceEpoch(map['endDate'] ?? 0);

        List<DateTime> visibleDates = viewChangedDetails.visibleDates;

        if (visibleDates.isNotEmpty) {
          DateTime calendarStartDate = visibleDates.first;
          DateTime calendarEndDate = visibleDates.last;

          if (selectedStartDate != calendarStartDate ||
              calendarEndDate != selectedEndDate) {
            SchedulerBinding.instance.addPostFrameCallback((duration) {
              calendarDateNotifier.value = {
                "startDate": calendarStartDate.millisecondsSinceEpoch,
                "endDate": calendarEndDate.millisecondsSinceEpoch,
              };
            });
          }
        }
      },
    );
  }

  // ===================================================================================
  Widget buidToggleButtons() {
    return CustomRowButtons(
      valueListenable: toggleValueNotifier,
      onChanged: (itemKey) {
        toggleValueNotifier.value = itemKey as CalendarView;
        calendarController.view = itemKey;
      },
      items: [
        CustomButtonModel(
          title: "Monthly",
          itemKey: CalendarView.month,
        ),
        CustomButtonModel(
          title: "Weekly",
          itemKey: CalendarView.week,
        ),
        CustomButtonModel(
          title: "Daily",
          itemKey: CalendarView.day,
        ),
      ],
    );
  }
}
