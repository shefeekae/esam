import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/services/platform_services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/services/theme/theme_services.dart';

class DateRangePickerButton extends StatefulWidget {
  const DateRangePickerButton(
      {required this.onChanged,
      this.initialDateTimeRange,
      this.firstDate,
      this.endDate,
      super.key});

  final Function(DateTimeRange dateTimeRange) onChanged;
  final DateTimeRange? initialDateTimeRange;
  final DateTime? firstDate;
  final DateTime? endDate;

  @override
  State<DateRangePickerButton> createState() => _DateRangePickerButtonState();
}

class _DateRangePickerButtonState extends State<DateRangePickerButton> {
  late ValueNotifier<DateTimeRange?> dateRangNotifier;

  @override
  void initState() {
    dateRangNotifier =
        ValueNotifier<DateTimeRange?>(widget.initialDateTimeRange);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTimeRange? dateTimeRange =
            await PlatformServices().showPlatformDateRange(
          context,
          initialDateRange: dateRangNotifier.value,
          firstDate: widget.firstDate,
          endDate: widget.endDate,
        );

        if (dateTimeRange != null) {
          dateRangNotifier.value = dateTimeRange;
          widget.onChanged(DateTimeRange(
              start: dateTimeRange.start,
              end: DateTime(dateTimeRange.end.year, dateTimeRange.end.month,
                  dateTimeRange.end.day, 23, 59, 59)));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
        decoration: BoxDecoration(
          color: ThemeServices().getBgColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ValueListenableBuilder<DateTimeRange?>(
          valueListenable: dateRangNotifier,
          builder: (context, value, _) {
            String startDateValue = value == null
                ? "Start Date"
                : DateFormat("MMM d y").format(value.start);

            String endDateValue = value == null
                ? "End Date"
                : DateFormat("MMM d y").format(value.end);

            TextStyle textStyle = TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w600,
              color: value == null ? Colors.grey : null,
            );

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(startDateValue, style: textStyle),
                SizedBox(
                  width: 5.sp,
                ),
                SizedBox(
                  width: 12.sp,
                  child: const Divider(
                    thickness: 1.5,
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Text(
                  endDateValue,
                  style: textStyle,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Icon(
                  Icons.date_range,
                  color: Theme.of(context).primaryColor,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
