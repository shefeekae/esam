import 'package:flutter/material.dart';

class DateHelpers {
  DateTime now = DateTime.now();

  DateTimeRange getPreviousMonthAndCurrentDateTime() {
    DateTime now = DateTime.now();

    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime start = today.subtract(const Duration(days: 30));

    return DateTimeRange(start: start, end: end);
  }

  DateTime getToday() {
    return DateTime(now.year, now.month, now.day);
  }

  DateTime getTodayEnd() {
    return DateTime(now.year, now.month, now.day, 23, 59);
  }

  DateTimeRange getTodayDateRange() {
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return DateTimeRange(start: startOfToday, end: endOfToday);
  }

  DateTimeRange get30DaysDateRange() {
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime thirtyDaysAgo = today.subtract(const Duration(days: 30));

    DateTime todayEnd =
        DateTime(today.year, today.month, today.day, 23, 59, 59);
    return DateTimeRange(
      start: thirtyDaysAgo,
      end: todayEnd,
    );
  }

  DateTimeRange getYesterdayStartTodayEndDateTimeRange() {
    // Get yesterday's start (midnight)
    DateTime yesterDayStart = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));

    // Get today's end (midnight)
    DateTime todayEnd = DateTime(now.year, now.month, now.day)
        .add(const Duration(hours: 23, minutes: 59, seconds: 59));
    return DateTimeRange(start: yesterDayStart, end: todayEnd);
  }  int getBillGenerateMonth() {
    return now.subtract(Duration(days: now.day < 15 ? 60 : 30)).month;
  }
}
