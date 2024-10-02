import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../../../core/models/alarms/alarm_comment_model.dart';
import '../../../../../../shared/functions/converters.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });

  final GetComments comment;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      comment.commentTime ?? 0,
    );

    return ListTile(
      minLeadingWidth: 10.sp,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        maxRadius: 13.sp,
        child: Text(
          Converter().largeLetterToSmall(comment.username ?? ""),
          style: TextStyle(
            fontSize: 10.sp,
            color: ThemeServices().getPrimaryFgColor(context),
          ),
        ),
      ),
      title: Text(comment.comment ?? ""),
      subtitle: Text(comment.username ?? ""),
      trailing: Text(
        timeago.format(dateTime),
        style: TextStyle(
          fontSize: 8.sp,
        ),
      ),
    );
  }
}
