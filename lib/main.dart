import 'package:flutter/material.dart';
import 'package:happy_birthday_mom/presentation/screens/pronostic_page.dart';
import 'package:happy_birthday_mom/presentation/screens/weather_Page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;



void main(){
  intl.Intl.defaultLocale = 'es_ES';
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {

  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'), // Español
        // ... otros locales que puedas necesitar
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.cyan
      ),
      //home: const WeatherPage()
      home: const WeatherPage(),
    );
  }

}