import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../shared/widgets/circle_avatar_with_text.dart';

class BuildCommentWidget extends StatelessWidget {
  const BuildCommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      margin: EdgeInsets.only(bottom: 5.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatarWithText(
            value: "MA",
            maxRadius: 13.sp,
            fgColor: kBlack,
          ),
          SizedBox(
            width: 10.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "mansoor@nectarit",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black38
                        : Colors.white38,
                  ),
                ),
                SizedBox(
                  height: 3.sp,
                ),
                Text(
                  "comment",
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "a minutes ago",
            style: TextStyle(
              fontSize: 8.sp,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}
