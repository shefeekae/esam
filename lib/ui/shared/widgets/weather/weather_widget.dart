import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'weather_icon_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    required this.dateTime,
    required this.title,
    required this.temperature,
    required this.iconId,
    super.key,
  });
  final String dateTime;
  final String title;
  final String temperature;
  final String iconId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(dateTime),
        SizedBox(
          height: 3.sp,
        ),
        WeatherIconWidget(iconId: iconId),
        SizedBox(
          height: 3.sp,
        ),
        Text(title),
        SizedBox(
          height: 3.sp,
        ),
        Text(
          "$temperature ℃",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

