import 'package:mini_projeto_5/provider/places_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/place_form_screen.dart';
import 'screens/places_list_screen.dart';
import 'screens/map_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesModel(),
      child: MaterialApp(
        title: 'My Places',
        theme: ThemeData().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.indigo,
                  secondary: Colors.amber,
                )),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.MAP: (ctx) => MapScreen(),
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
        },
      ),
    );
  }
}
