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
        title: const Text('Feliz Viaje', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, color: Colors.white)),
        centerTitle: true,
        //botones de actions
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.car_repair), 
          ),],
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            //  city name
            Text(_weather?.cityName ?? "Cargando ciudad...", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),

            //  animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
      
            //  temperatur
            Text('${_weather?.temperature.round()}°C', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300)),
            const SizedBox(height: 5),
            //  temperatur condicional
            Text(_weather?.mainCondition ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),

            const SizedBox(height: 10),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  min temp
                Text('Min: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Text('17°C', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                //separacion
                SizedBox(width: 10),
                //  max temp
                Text('Max: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                Text('34°C', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              ],
            )
          ],
        ),
      ),
    );
  }
}