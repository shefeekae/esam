import 'package:flutter/material.dart';
import 'package:nectar_assets/core/services/public%20api/weather_api_services.dart';
import 'package:nectar_assets/ui/shared/functions/epoch_to_formated_date.dart';
import 'package:sizer/sizer.dart';

import 'weather_widget.dart';

class WeatherListviewBuilder extends StatelessWidget {
  const WeatherListviewBuilder({
    required this.lat,
    required this.lng,
    super.key,
  });

  final num lat;
  final num lng;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.sp,
      child: FutureBuilder(
        future: WeatherAPIServices().getWeatherApI(
          lat: lat.toDouble(),
          lng: lng.toDouble(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return const SizedBox();
          }

          List weatherList = snapshot.data?["list"] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String, dynamic> map = weatherList[index];

              int epochTime = map['dt'];
              num temperature = map['main']?['temp'] ?? 0;

              List weather = map['weather'] ?? [];

              String title = weather.isEmpty
                  ? "N/A"
                  : weather.first?['description'] ?? "N/A";
              String iconId =
                  weather.isEmpty ? "" : weather.first?['icon'] ?? "";

              return WeatherWidget(
                dateTime: epochTimeToFormatedTime(epochTime, pattern: "h:mm a"),
                temperature: temperature.toString(),
                title: title,
                iconId: iconId,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 20.sp,
              );
            },
            itemCount: weatherList.length,
          );
        },
      ),
    );
  }
}
