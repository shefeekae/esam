import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:intl/intl.dart';
import 'package:nectar_assets/core/services/scheduler/sheduler_calendar_services.dart';
import 'package:rrule/rrule.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../../../core/models/scheduler/scheduler_list_model.dart';
import '../../../../../../core/services/theme/theme_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../shared/widgets/container_with_text.dart';
import '../details/scheduler_details.dart';

class SchedulerCard extends StatelessWidget {
  const SchedulerCard({required this.item, super.key});

  final Items item;



  String convertFrequency(Frequency freq) {
    if (freq == Frequency.yearly) return 'year';
    if (freq == Frequency.monthly) return 'month';
    if (freq == Frequency.weekly) return 'week';
    if (freq == Frequency.daily) return 'day';
    if (freq == Frequency.hourly) return 'hour';
    if (freq == Frequency.minutely) return 'minute';
    if (freq == Frequency.secondly) return 'second';

    return '';
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDay = DateTime.fromMillisecondsSinceEpoch(item.startDay ?? 0);

    DateTime endDay = DateTime.fromMillisecondsSinceEpoch(item.endDay ?? 0);

    bool isActive = item.status == "ACTIVE";

    bool recurring = item.recurring ?? false;

    return Bounce(
      duration: const Duration(milliseconds: 100),
      onPressed: () {
        Navigator.of(context).pushNamed(SchedulerDetailsScreen.id, arguments: {
          "id": item.id,
        });
      },
      child: Container(
        color: ThemeServices().getBgColor(context),
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10.sp,
                  color: isActive ? Colors.green : Colors.red,
                ),
                SizedBox(
                  width: 5.sp,
                ),
                Expanded(
                  child: Text(
                    item.name ?? "",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Builder(builder: (context) {
              RecurrenceType? recurrenceType;
              RecurrenceProperties? recurrenceProperties;

              if (item.rrule != null) {
                recurrenceProperties =
                    SfCalendar.parseRRule(item.rrule!, startDay);
                recurrenceType = recurrenceProperties.recurrenceType;
              }

              return ContainerWithTextWidget(
                value: SchedulerCalendarServices().getSchedulerTypeValue(
                  recurrenceType: recurrenceType,
                  recurring: recurring,
                  recurrenceProperties: recurrenceProperties,
                ),
                fgColor: ThemeServices().getPrimaryFgColor(context),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                fontSize: 8.sp,
              );
            }),
            SizedBox(
              height: 10.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRowDateTimesWidget(
                    firstValue: DateFormat("MMM - dd yyyy").format(startDay),
                    secondValue: DateFormat("MMM - dd yyyy").format(endDay)),
                buildRowDateTimesWidget(
                  firstValue: DateFormat().add_jm().format(startDay),
                  secondValue: DateFormat().add_jm().format(endDay),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================================

  getType(String? rrule) {}

// String getWeekDaysString(List<WeekDays> weekDays) =>
//       weekDays.map((e) => e.stringValue).toList().join(', ');

  // ======================================================================================================================
  Row buildRowDateTimesWidget({
    required String firstValue,
    required String secondValue,
  }) {
    return Row(
      children: [
        Text(
          firstValue,
          style: TextStyle(
            fontSize: 8.sp,
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        SizedBox(
          width: 6.sp,
          child: Divider(
            thickness: 1,
            color: kBlack,
          ),
        ),
        SizedBox(
          width: 5.sp,
        ),
        Text(
          secondValue,
          style: TextStyle(
            fontSize: 8.sp,
          ),
        ),
      ],
    );
  }
}
