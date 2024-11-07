import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/screens/abas.dart';
import 'package:mini_projeto_3/screens/configuracoes.dart';
import 'package:mini_projeto_3/screens/detalhes_lugar.dart';
import 'package:mini_projeto_3/screens/lugares_por_pais.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Lugar> _lugaresFavoritos = [];

  void toggleLugarFavorito(Lugar place) {
    setState(() {
      _lugaresFavoritos.contains(place)
          ? _lugaresFavoritos.remove(place)
          : _lugaresFavoritos.add(place);
    });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => MinhasAbas(listaFavoritos: _lugaresFavoritos,),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => DetalhesLugarScreen(onToggle: toggleLugarFavorito),
        '/configuracoes': (ctx) => ConfigracoesScreen(),
      },
    );

    /* return MaterialApp.router(
      routerConfig: minhasRotas.getRouter(),
    ); */
  }
}
