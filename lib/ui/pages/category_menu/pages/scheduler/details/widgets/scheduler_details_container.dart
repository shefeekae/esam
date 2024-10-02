import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/theme/theme_services.dart';
import 'package:sizer/sizer.dart';

class SchedulerDetailsContainer extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final String firstValue;
  final String secondValue;
  final IconData iconData;


  const SchedulerDetailsContainer({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstValue,
    required this.secondValue,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: ThemeServices().getBgColor(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 10.sp,
          ),
          buildLabel("$firstLabel: "),
          Expanded(child: buildValueText(firstValue)),
          buildLabel("$secondLabel: "),
          Expanded(child: buildValueText(secondValue))
        ],
      ),
    );
  }

  Text buildValueText(String value) => Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
      );

  Text buildLabel(String value) => Text(
        value,
        style: TextStyle(
          fontSize: 9.sp,
        ),
      );
}
