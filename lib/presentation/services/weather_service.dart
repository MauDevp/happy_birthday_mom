import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:happy_birthday_mom/presentation/models/weather_models.dart';

class WeatherServices {

  // ignore: constant_identifier_names
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric&lang=es'));
    
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el clima');
    }
  }

  Future<String> getCurrentCity() async {

    //Obtener permisos del usuario
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'No se han otorgado permisos';
      }
    }

    //Enviar la ubicación del usuario
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

    //Convertir la ubicación en una lista de placemarj objects
    List<Placemark> placemarks = 
    await placemarkFromCoordinates(position.latitude, position.longitude);


    //Extraer el nombre de la ciudad de la firstplacemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}