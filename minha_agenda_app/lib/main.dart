import 'package:flutter/material.dart';
import 'package:minha_agenda_app/pages/createContact.dart';
import 'package:minha_agenda_app/pages/detailContact.dart';
import 'package:minha_agenda_app/pages/manageContacts.dart';
import 'package:minha_agenda_app/pages/updateContact.dart';
import 'package:provider/provider.dart';

import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/utils/routes.dart';
import 'package:minha_agenda_app/pages/home.dart';
import 'package:minha_agenda_app/model/contact.dart';

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
          Routes.INPUT_CONTACT: (context) => CreateContact(),
          Routes.DETAIL_CONTACT: (context) {
            final Contact contact =
                ModalRoute.of(context)!.settings.arguments as Contact;
            return DetailContact(contact: contact);
          },
          Routes.UPDATE_CONTACT: (context) {
            final Contact contact =
                ModalRoute.of(context)!.settings.arguments as Contact;
            return UpdateContact(contact: contact);
          },
          Routes.MANAGE_CONTACT: (context) => ManageContacts()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
