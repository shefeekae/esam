import 'package:intl/intl.dart';

String epochTimeToFormatedTime(
  int epochTime, {
  required String pattern,
}) {
  try {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime);

    return DateFormat(pattern).format(dateTime);
  } catch (_) {
    return "N/A";
  }
}
