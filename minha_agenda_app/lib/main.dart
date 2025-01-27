import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/utils/routes.dart';
import 'package:minha_agenda_app/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactList(),
      child: MaterialApp(
        title: 'Minha Agenda App',
        theme: ThemeData(
            fontFamily: 'Inter',
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Colors.brown,
                surface: Color.fromRGBO(184, 184, 184, 70)),
            textTheme: TextTheme(
              headlineSmall: TextStyle(fontSize: 8, color: Colors.black),
              headlineMedium: TextStyle(fontSize: 16, color: Colors.black),
              headlineLarge: TextStyle(fontSize: 24, color: Colors.black),
              labelSmall: TextStyle(fontSize: 8, color: Colors.amber),
              labelMedium: TextStyle(fontSize: 16, color: Colors.amber),
              labelLarge: TextStyle(fontSize: 24, color: Colors.amber),
            )),
        home: Home(),
        routes: {
          //Routes.INTRO_FIRST_STEP: (context) => IntroFirstStep()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
