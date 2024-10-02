import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulerDataSource extends CalendarDataSource {
  SchedulerDataSource(this.source);

  List<Scheduler> source;

  @override
  List<Scheduler> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].endTime;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].schedulerName;
  }

  @override
  String? getStartTimeZone(int index) {
    return source[index].startTimeZone;
  }

  @override
  String? getEndTimeZone(int index) {
    return source[index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  @override
  String? getRecurrenceRule(int index) {
    return source[index].recurrenceRule;
  }

  @override
  List<DateTime>? getRecurrenceExceptionDates(int index) {
    // TODO: implement getRecurrenceExceptionDates
    return source[index].excludeDates;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future.delayed(Duration(seconds: 1));

    print("startdate: $startDate");
    print("endDate: $endDate");
    // TODO: implement handleLoadMore
    // return super.handleLoadMore(startDate, endDate);
  }

  @override
  Object? convertAppointmentToObject(
      Object? customData, Appointment appointment) {
    // TODO: implement convertAppointmentToObject

    Scheduler scheduler = customData as Scheduler;

    return Scheduler(
      id: scheduler.id,
      schedulerName: scheduler.schedulerName,
      startTime: appointment.startTime,
      endTime: appointment.endTime,
      background: appointment.color,
      isAllDay: appointment.isAllDay,
      recurrenceRule: appointment.recurrenceRule,
      excludeDates: appointment.recurrenceExceptionDates,
    );
    // recurrenceId: appointment.recurrenceId,
    // exceptionDates: appointment.recurrenceExceptionDates);
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Scheduler {
  Scheduler({

    required this.id,
    required this.schedulerName,
    required this.startTime,
    required this.endTime,
    required this.background,
    required this.isAllDay,
    this.startTimeZone,
    this.endTimeZone,
    this.recurrenceRule,
    this.excludeDates,
  });

  int? id;
  String schedulerName;
  DateTime startTime;
  DateTime endTime;
  Color background;
  bool isAllDay;
  String? startTimeZone;
  String? endTimeZone;
  String? recurrenceRule;
  List<DateTime>? excludeDates;
  // List<RosterDetail> rosterDetails;
}
