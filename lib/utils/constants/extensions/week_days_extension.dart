


import 'package:syncfusion_flutter_calendar/calendar.dart';

extension WeekDaysExtension on WeekDays {
  String get stringValue {
    switch (this) {
      case WeekDays.sunday:
        return 'Sun';
      case WeekDays.monday:
        return 'Mon';
      case WeekDays.tuesday:
        return 'Tue';
      case WeekDays.wednesday:
        return 'Wed';
      case WeekDays.thursday:
        return 'Thu';
      case WeekDays.friday:
        return 'Fri';
      case WeekDays.saturday:
        return 'Sat';
    }
  }
}