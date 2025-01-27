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
                primary: Color.fromRGBO(213, 29, 72, 100),
                surface: Color.fromRGBO(184, 184, 184, 70)),
            textTheme: TextTheme(
              headlineSmall: TextStyle(
                  fontSize: 8, color: Color.fromRGBO(56, 31, 126, 100)),
              headlineMedium: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(56, 31, 126, 100)),
              headlineLarge: TextStyle(
                  fontSize: 24, color: Color.fromRGBO(56, 31, 126, 100)),
              labelSmall: TextStyle(
                  fontSize: 8, color: Color.fromRGBO(153, 53, 53, 100)),
              labelMedium: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(153, 53, 53, 100)),
              labelLarge: TextStyle(
                  fontSize: 24, color: Color.fromRGBO(153, 53, 53, 100)),
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
