import 'package:flutter/material.dart';
import 'package:happy_birthday_mom/presentation/models/weather_models.dart';
import 'package:happy_birthday_mom/presentation/screens/pronostic_page.dart';
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
    //  obtener la ubicacion de la ciudad
    String cityName = await _weatherServices.getCurrentCity();

    //  obtener el tiempo de la ciudad
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
  if(mainCondition == null) return 'assets/day/charging.json'; //default to sunny

        // Obtén la hora actual
  final hour = DateTime.now().hour;

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

    //  fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Toda la configuracion del appbar
        backgroundColor: Color.fromARGB(255, 214, 144, 212),
        // texto del appbar
        title: const Text('Buen Viaje Mamá', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300, color: Colors.white)),
        centerTitle: true,
        //boton para ir a pantalla de pronostico
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PronosticPage()),
              );
            },
            icon: const Icon(Icons.navigate_next_rounded, color: Colors.black54, size: 30,), 
          ),],
        //boton de actualizar textos
        leading: IconButton(
          onPressed: (){
            setState(() {
              _weather = null;
              _fetchWeather();
            });
          },
          icon: const Icon(Icons.location_on, color: Colors.black54, size: 30,), 
        ),
      ),
      //  fondo de la pantalla
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            //  texto descriptivo
            Spacer(),
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

            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("❤️ TQM MAMA Attm: Tus hijos ❤️", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),),
              ],
            )
          ],
        ),
      ),
    );
  }
}