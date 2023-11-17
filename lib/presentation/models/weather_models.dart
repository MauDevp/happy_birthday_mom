class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String detalles;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.detalles,
    });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      detalles: json['weather'][0]['description'],
    );
  }
}