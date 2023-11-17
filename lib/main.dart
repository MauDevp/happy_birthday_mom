import 'package:flutter/material.dart';
import 'package:happy_birthday_mom/presentation/screens/pantallaPrincipal.dart';


void main(){
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {

  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.cyan
      ),
      home: const PantallaPrincipal()
    );
  }

}