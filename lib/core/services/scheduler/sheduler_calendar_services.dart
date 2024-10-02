import 'package:flutter/material.dart';
import 'package:nectar_assets/core/models/scheduler/scheduler_list_model.dart';
import 'package:nectar_assets/core/services/scheduler/scheduler_calendar_data_source.dart';
import 'package:nectar_assets/utils/constants/extensions/color_extensions.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../models/scheduler/scheduler_calendar_model.dart';

class SchedulerCalendarServices {
  Map<dynamic, String> weekDaysValueMap = {
    WeekDays.monday: "Mon",
    WeekDays.tuesday: "Tue",
    WeekDays.wednesday: "Wed",
    WeekDays.thursday: "Thur",
    WeekDays.friday: "Fri",
    WeekDays.saturday: "Sat",
    WeekDays.sunday: "Sun",
  };

  Map<dynamic, String> repeatsTypesMap = {
    RecurrenceType.daily: "Daily",
    RecurrenceType.weekly: "Weekly",
    RecurrenceType.monthly: "Monthly",
    RecurrenceType.yearly: "Yearly",
  };

  // ======================================================================

  List<Scheduler> getSchedulerCalendarDataSource({
    required BuildContext context,
    required List<SchedulerItem> schedulerList,
  }) {
    return schedulerList.map((e) {
      DateTime startDay = DateTime.fromMillisecondsSinceEpoch(e.startDay ?? 0);

      DateTime endDay = DateTime.fromMillisecondsSinceEpoch(e.endDay ?? 0);

      Color background = e.color == null
          ? Theme.of(context).primaryColor
          : HexColor.fromHex(e.color!);

      DateTime endTime = DateTime(startDay.year, startDay.month, startDay.day,
          endDay.hour, endDay.minute, endDay.second);

      return Scheduler(
        id: e.id,
        schedulerName: e.name ?? "",
        startTime: startDay,
        endTime: DateTime(
          startDay.year,
          startDay.month,
          endTime.hour > startDay.hour ? startDay.day : startDay.day + 1,
          endDay.hour,
          endDay.minute,
          endDay.second,
        ),
        recurrenceRule: e.rrule,
        background: background,
        isAllDay: false,
      );
    }).toList();
  }

  //  =============================================================================
  // Get scheduler repeats type

  String getSchedulerRepeatsType(RecurrenceType recurrenceType) =>
      repeatsTypesMap[recurrenceType] ?? "N/A";

//  ===============================================================================

  String getSchedulerTypeValue({
    required RecurrenceType? recurrenceType,
    required bool recurring,
    required RecurrenceProperties? recurrenceProperties,
  }) {
    if (!recurring || recurrenceType == null) {
      return "One Time";
    }

    if (recurrenceType == RecurrenceType.daily) {
      int intervel = recurrenceProperties?.interval ?? 0;

      if (intervel == 0 || intervel == 1) {
        return "Repeats every day";
      }

      return "Repeats every $intervel days";
    }

    if (recurrenceType == RecurrenceType.weekly) {
      List<WeekDays> weekDays = recurrenceProperties?.weekDays ?? [];

      if (weekDays.length == 7) {
        return "Repeats every day";
      }

      return "Repeats every week on ${weekDays.map((e) => weekDaysValueMap[e]).toList().join(", ")}";
    }

    if (recurrenceType == RecurrenceType.monthly) {
      int intervel = recurrenceProperties?.interval ?? 0;

      if (intervel != 0) {
        return "Repeats every $intervel months";
      }

      return "Repeats every day";
    }

    if (recurrenceType == RecurrenceType.yearly) {
      return "Repeats every year";
    }

    return "Repeats";
  }
}
