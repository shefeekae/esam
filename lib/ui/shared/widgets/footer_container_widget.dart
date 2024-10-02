import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:nectar_assets/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class FooterContainerButtonWidget extends StatelessWidget {
  FooterContainerButtonWidget({
    super.key,
    required this.keyValue,
    required this.label,
    this.onPressed = defaultFunction,
  });

  String keyValue;
  String label;

  static void defaultFunction() {
    print('save function called!');
  }

  void Function() onPressed;

  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Bounce(
        duration: const Duration(milliseconds: 100),
        onPressed:onPressed,
        child: Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: keyValue == "save" ? primaryColor : kWhite,
            border: keyValue == "save"
                ? null
                : Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
          ),
          child: Center(
            child: Text(
              label,
              style: textStyle.copyWith(
                color: keyValue == "save" ? kWhite : primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
