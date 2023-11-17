//  importacion
import 'package:flutter/material.dart';
import 'package:happy_birthday_mom/presentation/models/weather_models.dart';
import 'package:happy_birthday_mom/presentation/models/pronostic_models.dart';
import 'package:happy_birthday_mom/presentation/screens/weather_page.dart';
import 'package:happy_birthday_mom/presentation/services/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:happy_birthday_mom/presentation/services/pronostic_service.dart';
import 'package:intl/intl.dart';

//  clase statefulwidget
class PronosticPage extends StatefulWidget {
  const PronosticPage({super.key});


  @override
  State<PronosticPage> createState() => _PronosticPageState();
}

//  clase state
class _PronosticPageState extends State<PronosticPage> {
  List<HourlyForecast>? _hourlyForecast;
  
  //  api key
  final _weatherServices = WeatherServices(apiKey: 'ab257ee0c6fdd62eb623c952c014d722');

//  importacion
  HourlyWeather? _hourlyWeather;

  //  fetch weather
  /*_fetchWeatherHours() async{
    //  obtener la ubicacion de la ciudad
    String cityName = await _weatherServices.getCurrentCity();

    //  obtener el tiempo de la ciudad
    try{
      final HourlyWeather = await _weatherServices.getHourlyWeather(cityName);
      setState(() {
        _hourlyWeather = HourlyWeather;
      });
    }

    //  any errors
    catch (e){
      print(e);
    }
  }
*/
  //  weather animations
String getWeatherAnimation(String? mainCondition){
  if(mainCondition == null) return 'assets/sunny.json'; //default to sunny

  switch(mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/cloud.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rain.json';
    case 'thunderstorm':
      return 'assets/thunderstorm.json';
    case 'clear':
      return 'assets/sunny.json';
    default:
      return 'assets/sunny.json';
  }
}

String getWeatherCondition(String? mainCondition){
  if(mainCondition == null) return 'cargando...'; //default to 'cargando...'

  switch(mainCondition.toLowerCase()){
    case 'clouds':
      return 'Nubes';
    case 'mist':
      return 'Neblina';
    case 'smoke':
      return 'Humo';
    case 'haze':
      return 'brumoso';
    case 'dust':
      return 'Polvoso';
    case 'fog':
      return 'Niebla';
    case 'rain':
      return 'Lluvioso';
    case 'drizzle':
      return 'Llovizna';
    case 'shower rain':
      return 'Aguacero';
    case 'thunderstorm':
      return 'Tormena';
    case 'clear':
      return 'Despejado';
    default:
      return 'Cargando...';
  }
}

  //  init state
  @override
  void initState() {
    super.initState();
    _fetchWeatherHours();
  }

    Future<void> _fetchWeatherHours() async {
    String cityName = await _weatherServices.getCurrentCity();
    _hourlyForecast = await fetchHourlyForecast(cityName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        title: const Text('Pronóstico del clima', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _fetchWeatherHours,
            icon: const Icon(Icons.location_on),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WeatherPage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _hourlyForecast == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _hourlyForecast!.length,
              itemBuilder: (context, index) {
                final forecast = _hourlyForecast![index];
                final formattedDate = DateFormat('d MMMM, hh:mm a').format(forecast.time);
                return ListTile(
                  title: Text('$formattedDate: ${forecast.description}'),
                  subtitle: Text('${forecast.temperature.round()}°C'),
                );
              },
            ),
    );
  }
}
