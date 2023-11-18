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
  Weather? _weather;

  //  fetch weather
_fetchWeatherCity() async{
    //  obtener la ubicacion de la ciudad
    String cityName = await _weatherServices.getCurrentCity();

    //  obtener el tiempo de la ciudad
    Weather weather = await _weatherServices.getWeather(cityName);

    setState(() {
        _weather = weather;
    });
}

  //  weather animations
String getWeatherAnimation(String? mainCondition, DateTime time){
  if(mainCondition == null) return 'assets/day/charging.json'; //default to sunny

      // Obtén la hora actual
  final hour = time.hour;

  // Determina si es de día o de noche
  final isDayTime = hour > 6 && hour < 19;

  switch(mainCondition.toLowerCase()){
    case 'clouds':
      return isDayTime ? 'assets/day/clouds.json' : 'assets/night/cloud.json';
    case 'mist':
      return isDayTime ? 'assets/day/clouds.json' : 'assets/night/cloud.json';
    case 'smoke':
      return isDayTime ? 'assets/day/sunny.json' : 'assets/night/moon.json';
    case 'haze':
      return isDayTime ? 'assets/day/sunny.json' : 'assets/night/moon.json';
    case 'dust':
      return isDayTime ? 'assets/day/sunny.json' : 'assets/night/moon.json';
    case 'fog':
      return isDayTime ? 'assets/day/cloud.json' : 'assets/night/cloud.json';
    case 'rain':
      return isDayTime ? 'assets/day/rain.json' : 'assets/night/rain.json';
    case 'drizzle':
      return isDayTime ? 'assets/day/rain.json' : 'assets/night/rain.json';
    // Añade más condiciones climáticas aquí...
    default:
      return isDayTime ? 'assets/day/sunny.json' : 'assets/night/moon.json';
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
    _fetchWeatherCity();
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
        backgroundColor: Colors.purple[300],
        title: const Text('Eres la mejor', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async{
              await _fetchWeatherCity();
              await _fetchWeatherHours();
            },
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
          icon: const Icon(Icons.navigate_before_rounded, color: Colors.black54, size: 30,),
        ),
      ),
      backgroundColor: Colors.lightBlue[100],
      body:_hourlyForecast == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
            children: [
              const SizedBox(height: 10,),
              const Text('Pronostico del clima:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
              Text(_weather?.cityName ?? 'Cargando...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              
              Expanded(
                child: ListView.builder(
                  itemCount: _hourlyForecast!.length,
                  itemBuilder: (context, index) {
                    final forecast = _hourlyForecast![index];
                    final formattedDate = DateFormat('E d MMM').format(forecast.time);
                    final formattedTime = DateFormat('hh:mm a').format(forecast.time);
                    
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //  row de animation y del DataTime
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Lottie.asset(getWeatherAnimation(forecast.condition, forecast.time )),
                                ),
                                Text('${formattedDate} \n ${formattedTime}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('(', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                Text('${forecast.temperature.round()}°C', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                Text(') - ${getWeatherCondition(forecast.condition)} ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                )
            ],
          ),
    );
  }
}
