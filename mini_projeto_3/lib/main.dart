import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/screens/abas.dart';
import 'package:mini_projeto_3/screens/configuracoes.dart';
import 'package:mini_projeto_3/screens/detalhes_lugar.dart';
import 'package:mini_projeto_3/screens/lugares_por_pais.dart';
import 'package:mini_projeto_3/screens/adicionarLugar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
      create: (context) => PaisesModel(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (ctx) => MinhasAbas(),
          '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
          '/detalheLugar': (ctx) => DetalhesLugarScreen(),
          '/configuracoes': (ctx) => ConfigracoesScreen(),
          '/adicionarLugar': (ctx) => AdicionarLugar(),
        },
      )
    )    ;

    /* return MaterialApp.router(
      routerConfig: minhasRotas.getRouter(),
    ); */
  }
}