import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center (child: Text("Pantalla principal")),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hola mundo Mau",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
              Text("click"),
            ],
          ),
        )
      );
  }
}