import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherAPIServices {
  var url = Uri.parse('');

  final String apIkey = "0addfeb59411d4e60990492fd22fb2c1";

Future<Map<String,dynamic>>  getWeatherApI({required double lat, required double lng}) async {
    var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lng&units=metric&APPID=$apIkey",
    );
    var response = await http.get(url);
   

    return jsonDecode(response.body);
  }
}
