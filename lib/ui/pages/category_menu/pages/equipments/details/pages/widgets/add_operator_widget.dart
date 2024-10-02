import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_config/graphql_config.dart';
import 'package:graphql_config/widget/mutation_widget.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/models/asset/list_all_operators_model.dart';
import 'package:nectar_assets/core/models/asset/list_paginated_shifts_model.dart';
import 'package:nectar_assets/core/schemas/assets_schema.dart';
import 'package:nectar_assets/core/services/graphql_services.dart';
import 'package:nectar_assets/core/services/platform_services.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:nectar_assets/ui/shared/widgets/buttons/custom_elevated_button.dart';
import 'package:rrule/rrule.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../shared/widgets/required_text.dart';

class AddOperatorWidget extends StatefulWidget {
  const AddOperatorWidget({
    super.key,
    required this.ownerClientId,
    required this.identifier,
  });

  final String ownerClientId;
  final String identifier;

  @override
  State<AddOperatorWidget> createState() => _AddOperatorWidgetState();
}

class _AddOperatorWidgetState extends State<AddOperatorWidget> {
  ValueNotifier<List<Map<String, dynamic>>> checkListItemsNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([
    {
      "isChecked": false,
      "title": "Sun",
      "value": 7,
    },
    {
      "isChecked": true,
      "title": "Mon",
      "value": 1,
    },
    {
      "isChecked": true,
      "title": "Tue",
      "value": 2,
    },
    {
      "isChecked": true,
      "title": "Wed",
      "value": 3,
    },
    {
      "isChecked": true,
      "title": "Thu",
      "value": 4,
    },
    {
      "isChecked": true,
      "title": "Fri",
      "value": 5,
    },
    {
      "isChecked": false,
      "title": "Sat",
      "value": 6,
    },
  ]);

  String? shiftDropdownValue;
  String? assigneeDropdownValue;

  ValueNotifier<List<int>> excludeDaysNotifier = ValueNotifier([]);

  // List<int> daysOfWeek = [
  //   1,
  //   2,
  // ];

  UserDataSingleton userData = UserDataSingleton();

  ValueNotifier<DateTimeRange> dateRangeNotifier =
      ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  ValueNotifier<String> selectedShift = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    // daysOfWeek.clear();

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const RequiredTextWidget(
                title: "Date Range",
              ),
              SizedBox(
                height: 7.sp,
              ),
              buildDateRange(context),
              SizedBox(
                height: 15.sp,
              ),
              const RequiredTextWidget(
                title: "Repeat On",
              ),
              SizedBox(
                height: 7.sp,
              ),
              buildRepeatedOn(),
              SizedBox(
                height: 15.sp,
              ),
              const RequiredTextWidget(
                title: "Exclude Days",
                required: false,
              ),
              SizedBox(
                height: 7.sp,
              ),
              ValueListenableBuilder(
                  valueListenable: excludeDaysNotifier,
                  builder: (context, excludeDaysList, child) {
                    return GestureDetector(
                      onTap: () async {
                        var result = await showCalendarDatePicker2Dialog(
                          context: context,
                          value: excludeDaysNotifier.value
                              .map(
                                  (e) => DateTime.fromMillisecondsSinceEpoch(e))
                              .toList(),
                          config: CalendarDatePicker2WithActionButtonsConfig(
                            calendarType: CalendarDatePicker2Type.multi,
                            firstDate: dateRangeNotifier.value.start,
                            lastDate: dateRangeNotifier.value.end,
                            selectableDayPredicate: (day) {
                              List<Map<String, dynamic>> list =
                                  checkListItemsNotifier.value;

                              Iterable<int> values = list
                                  .where((element) => element['isChecked'])
                                  .map((e) => e['value']);

                              return values.contains(day.weekday);
                            },
                          ),
                          dialogSize: const Size(325, 400),
                        );

                        if (result != null) {
                          var data = result
                              .where((element) => element != null)
                              .toList();

                          excludeDaysNotifier.value = data
                              .map((dateTime) =>
                                  dateTime?.millisecondsSinceEpoch ?? 0)
                              .toList();
                          excludeDaysNotifier.notifyListeners();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeServices().getBgColor(context),
                            borderRadius: BorderRadius.circular(5.sp)),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: ValueListenableBuilder(
                              valueListenable: excludeDaysNotifier,
                              builder: (context, excludeDaysEpoc, child) {
                                return excludeDaysEpoc.isEmpty
                                    ? Text(
                                        "Select Exclude Days",
                                        style: TextStyle(fontSize: 12.sp),
                                      )
                                    : Wrap(
                                        children: List.generate(
                                          excludeDaysEpoc.length,
                                          (index) {
                                            String excludeDate = DateFormat(
                                                    "dd MMM yyyy")
                                                .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        excludeDaysEpoc[
                                                            index]));

                                            return Container(
                                              margin: EdgeInsets.all(5.sp),
                                              padding: EdgeInsets.all(5.sp),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.sp),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              child: Text(excludeDate),
                                            );
                                          },
                                        ),
                                      );
                              }),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 15.sp,
              ),
              const RequiredTextWidget(
                title: "Shift",
              ),
              SizedBox(
                height: 7.sp,
              ),
              QueryWidget(
                  options: GraphqlServices().getQueryOptions(
                    query: AssetSchema.listAllPaginatedShifts,
                    variables: {
                      "queryParam": {"page": 0, "size": 10},
                      "body": {
                        "domain": userData.domain,
                        "clients": [widget.ownerClientId],
                        "clientFlag": false
                      }
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (result.hasException) {
                      return GraphqlServices().handlingGraphqlExceptions(
                          result: result, context: context, refetch: refetch);
                    }

                    var data = result.data!;

                    List<Shift> shifts = listPaginatedShiftsModelFromJson(data)
                            .listPaginatedShifts
                            ?.items ??
                        [];

                    if (shifts.isEmpty) {
                      return const Center(
                          child: Text("No shifts are available"));
                    }

                    String hintText = "Select Shift";

                    return StatefulBuilder(builder: (context, setState) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ThemeServices().getBgColor(context),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(5.sp),
                          elevation: 2,
                          underline: const SizedBox(),
                          value: shiftDropdownValue,
                          hint: Text(hintText),
                          items: shifts
                              .map<DropdownMenuItem<String>>((Shift shift) {
                            DateTime startTime = DateFormat('HH:mm:ss')
                                .parse(shift.startTime ?? "", true)
                                .toLocal();

                            DateTime endTime = DateFormat('HH:mm:ss')
                                .parse(shift.endTime ?? "", true)
                                .toLocal();

                            // Format the DateTime to AM/PM format
                            String formattedStartTime =
                                DateFormat('h:mm a').format(startTime);

                            String formattedEndTime =
                                DateFormat('h:mm a').format(endTime);

                            return DropdownMenuItem(
                                value: shift.identifier,
                                child: Text(
                                    "${shift.name}   ($formattedStartTime - $formattedEndTime)"));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(
                                () {
                                  shiftDropdownValue = value;

                                  print(
                                      "DropDown value printed : $shiftDropdownValue");
                                },
                              );
                            }
                          },
                        ),
                      );
                    });
                  }),
              SizedBox(
                height: 15.sp,
              ),
              const RequiredTextWidget(
                title: "Assignee",
              ),
              SizedBox(
                height: 7.sp,
              ),
              QueryWidget(
                  options: GraphqlServices().getQueryOptions(
                    query: AssetSchema.listAllOperatorsSchema,
                    variables: {
                      "type": "Operator",
                      "pagination": {"page": 0, "size": 10, "sort": "name,ASC"},
                      "extend": true,
                      "domain": userData.domain
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (result.hasException) {
                      return GraphqlServices().handlingGraphqlExceptions(
                          result: result, context: context, refetch: refetch);
                    }

                    var data = result.data!;

                    ListAllOperatorsModel listAllOperatorsModel =
                        listAllOperatorsModelFromJson(data);

                    List<Assignee> assignees =
                        listAllOperatorsModel.listAllOperatorsPaged?.items ??
                            [];

                    if (assignees.isEmpty) {
                      return const Center(
                          child: Text("No Assignees are available"));
                    }

                    String hintText = "Select Assignee";

                    return StatefulBuilder(builder: (context, setState) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ThemeServices().getBgColor(context),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(5.sp),
                          elevation: 2,
                          underline: const SizedBox(),
                          value: assigneeDropdownValue,
                          hint: Text(hintText),
                          items: assignees.map<DropdownMenuItem<String>>(
                              (Assignee assignee) {
                            print("Id : ${assignee.id}");

                            return DropdownMenuItem(
                                value: assignee.id.toString(),
                                child: Text("${assignee.name}"));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(
                                () {
                                  assigneeDropdownValue = value;

                                  print(
                                      "DropDown value printed : $assigneeDropdownValue");
                                },
                              );
                            }
                          },
                        ),
                      );
                    });
                  }),
            ],
          ),
        ),
        MutationWidget(
          options: GrapghQlClientServices().getMutateOptions(
            document: AssetSchema.createGroupOverrideRosterMutation,
            context: context,
            onCompleted: (value) {
              if (value != null) {
                print(value);
                Navigator.of(context).pop(true);
              }
            },
          ),
          builder: (runMutation, result) {
            return CustomElevatedButton(
              isLoading: result?.isLoading ?? false,
              onPressed: () {
                bool isChecklistNotEmpty = checkListItemsNotifier.value
                    .any((element) => element["isChecked"]);

                if (!isChecklistNotEmpty ||
                    shiftDropdownValue == null ||
                    assigneeDropdownValue == null) {
                  PlatformServices().showPlatformAlertDialog(
                    context,
                    message: "Required fields are empty",
                    title: "Alert",
                  );
                  return;
                }

                List<ByWeekDayEntry> byWeekDays = checkListItemsNotifier.value
                    .where((element) => element['isChecked'])
                    .map((e) => ByWeekDayEntry(e['value']))
                    .toList();

                RecurrenceRule rrule = RecurrenceRule(
                  frequency: Frequency.weekly,
                  interval: 1,
                  weekStart: 1,
                  byWeekDays: byWeekDays,
                  until: dateRangeNotifier.value.end.toUtc(),
                );

                String cronData = rrule.toString().replaceFirst("RRULE:", "");

                String formattedRruleString = formatRrule(cronData);

                var payload = {
                  "rosterGroup": [
                    {
                      "assigneeResources": [
                        {
                          "assigneeId": int.parse(assigneeDropdownValue!),
                          "resourceId": widget.identifier,
                        }
                      ],
                      "domain": widget.ownerClientId,
                      "startDate":
                          dateRangeNotifier.value.start.millisecondsSinceEpoch,
                      "endDate": dateRangeNotifier.value.end
                          .add(const Duration(
                              hours: 23, minutes: 59, seconds: 59))
                          .millisecondsSinceEpoch,
                      "shiftId": shiftDropdownValue,
                      "skipList": excludeDaysNotifier.value,
                      "cronData": formattedRruleString,
                      "status": "ACTIVE"
                    }
                  ]
                };

                runMutation(payload);
              },
              title: "Save",
            );
          },
        )
      ],
    );
  }

  // ===========================================================================
  ValueListenableBuilder buildRepeatedOn() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: checkListItemsNotifier,
        builder: (context, checkListItems, _) {
          return Wrap(
            children: List.generate(
              checkListItems.length,
              (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: checkListItems[index]["isChecked"],
                      onChanged: (value) {
                        if (value != null) {
                          checkListItems[index]["isChecked"] = value;
                          checkListItemsNotifier.value =
                              List.from(checkListItems);

                          // if (checkListItems[index]["isChecked"]) {
                          //   // daysOfWeek.add(checkListItems[index]["value"]);
                          // }

                          // if (!checkListItems[index]["isChecked"]) {
                          //   daysOfWeek.remove(checkListItems[index]["value"]);
                          // }
                        }
                      },
                    ),
                    Text(
                      checkListItems[index]["title"],
                    ),
                    SizedBox(
                      width: 5.sp,
                    )
                  ],
                );
              },
            ),
          );
        });
  }

  GestureDetector buildDateRange(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTimeRange? dateTimeRange = await showDateRangePicker(
          builder: (context, child) {
            return Theme(
                data: ThemeData(
                    primaryColorDark: Colors.red,
                    primaryColor: Colors.red,
                    appBarTheme:
                        const AppBarTheme(backgroundColor: Colors.black)),
                child: child!);

            //   return Theme(
            // data: Theme.of(context).copyWith(
            //   colorScheme: ColorScheme.light(
            //     primary: Colors.yellow, // header background color
            //     onPrimary: Colors.black, // header text color
            //     onSurface: Colors.green, // body text color
            //   );
          },
          initialDateRange: dateRangeNotifier.value,
          context: context,
          firstDate: DateTime.now().subtract(
            const Duration(
              days: 365 * 100,
            ),
          ),
          lastDate: DateTime(3000),
        );

        if (dateTimeRange != null) {
          dateRangeNotifier.value = dateTimeRange;
          dateRangeNotifier.notifyListeners();
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getBgColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ValueListenableBuilder(
            valueListenable: dateRangeNotifier,
            builder: (context, dateRange, child) {
              String startDate =
                  DateFormat("dd MMM yyyy").format(dateRange.start);
              String endDate = DateFormat("dd MMM yyyy").format(dateRange.end);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    startDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    endDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.date_range)
                ],
              );
            }),
      ),
    );
  }

  String formatRrule(String rruleString) {
    var list = rruleString.split(';');

    String until = list[1];

    String intervel = list[2];
    String byday = list[3];
    // String weekStart = 'WKST=SU';

    String formattedRrule = "FREQ=WEEKLY;$intervel;WKST=SU;$byday;${until}Z";

    return formattedRrule;
  }
}
