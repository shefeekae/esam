import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildTitleAndData extends StatelessWidget {
  const BuildTitleAndData(
      {required this.title, required this.values, super.key});

  final String title;
  final List values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 2.sp,
        ),
        ...List.generate(
          values.length,
          (index) => Column(
            children: [
              Text(
                values[index].toString(),
                style: TextStyle(
                  height: 1.3,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Visibility(
                visible: values.length != 1,
                child: SizedBox(
                  height: 5.sp,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 13.sp,
        ),
      ],
    );
  }
}
