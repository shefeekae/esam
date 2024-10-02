// ====================================================================================
// REGISTER A NEW ACCOUNT.

import 'package:flutter/cupertino.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

Row buildRegisterOrLogin(
    {required BuildContext context,
    required String title,
    required String subTitle,
    required void Function() onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(
          color: kWhite.withOpacity(0.5),
          fontSize: 10.sp,
        ),
      ),
      SizedBox(
        width: 5.sp,
      ),
      CupertinoButton(
        // borderRadius: BorderRadius.zero,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Text(
          subTitle,
          style: TextStyle(
            color: kWhite,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}


