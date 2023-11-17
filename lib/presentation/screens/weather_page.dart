import 'package:flutter/material.dart';
import 'package:happy_birthday_mom/presentation/models/weather_models.dart';
import 'package:happy_birthday_mom/presentation/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //  api key
  final _weatherServices = WeatherServices(apiKey: 'ab257ee0c6fdd62eb623c952c014d722');
  Weather? _weather;

  //  fetch weather
  _fetchWeather() async{
    //  get the current city
    String cityName = await _weatherServices.getCurrentCity();

    //  get weather for city
    try{
      final Weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = Weather;
      });
    }

    //  any errors
    catch (e){
      print(e);
    }
  }

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

    //  fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Toda la configuracion del appbar
        backgroundColor: Colors.blueAccent[200],
        title: const Text('Buen Viaje Mamá', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, color: Colors.white)),
        centerTitle: true,
        //botones de actions
        actions: [
          IconButton(
            onPressed: (){
              _fetchWeather();
            },
            icon: const Icon(Icons.replay_outlined), 
          ),],
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text('Ciudad:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),

            //  nombre de la ciudad
            Text(_weather?.cityName ?? "Cargando ciudad...", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),

            //  animacion
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
      
            //  temperatura
            Text('${_weather?.temperature.round()}°C', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300)),

            //  condicion del clima
            Text(getWeatherCondition(_weather?.mainCondition), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            //  descripcion del clima
            Text(_weather?.detalles ?? 'Cargando descripción...', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}