import 'package:flutter/material.dart';
import 'Screens/cubeLayout.dart';
import 'Screens/forms.dart';
import 'Screens/IMC.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: 'Meu App Ola Mundo',
      home: CubeLayout(),
    );
  }
}