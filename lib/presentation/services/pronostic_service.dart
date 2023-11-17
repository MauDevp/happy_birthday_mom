import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<HourlyForecast>> fetchHourlyForecast(String city) async {
  final response = await http.get(
    Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=ab257ee0c6fdd62eb623c952c014d722'),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> hourlyData = data['list'];

    return hourlyData.take(4).map((json) => HourlyForecast.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load hourly forecast');
  }
}

class HourlyForecast {
  final DateTime time;
  final String description;
  final double temperature;

  HourlyForecast({
    required this.time,
    required this.description,
    required this.temperature,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'] - 273.15,
    );
  }
}