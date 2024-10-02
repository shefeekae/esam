import 'package:flutter/material.dart';
import 'package:nectar_assets/ui/pages/category_menu/pages/alarms/list/widgets/comments/comment_textfield_with_mutation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';

class BuildImageWithTextfield extends StatelessWidget {
  const BuildImageWithTextfield({
    super.key,
    required this.eventId,
  });

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 10.sp,
            backgroundColor: f1White,
            child: const Icon(Icons.person),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Expanded(
            child: SizedBox(
              height: 25.sp,
              child: CommentTextfieldWithMutationWidget(
                eventId: eventId,
                onCompleted: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
