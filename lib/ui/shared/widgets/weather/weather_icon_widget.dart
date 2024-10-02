import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WeatherIconWidget extends StatelessWidget {
  const WeatherIconWidget({
    super.key,
    required this.iconId,
  });

  final String iconId;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color.fromRGBO(132, 205, 238, 1),
      minRadius: 20.sp,
      backgroundImage: iconId.isEmpty
          ? null
          : NetworkImage("https://openweathermap.org/img/wn/$iconId@2x.png"),
    );
  }
}
