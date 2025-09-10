import 'package:flutter/material.dart';
import 'formulario.dart';  
import 'vista/succes.dart';
import "vista/inicial.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario Simple',
      debugShowCheckedModeBanner: false,
      home: initial()
    );
  }
}
