class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String condition;
  final String description;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.description,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}