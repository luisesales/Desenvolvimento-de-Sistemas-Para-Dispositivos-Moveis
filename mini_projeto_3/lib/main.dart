import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/screens/abas.dart';
import 'package:mini_projeto_3/screens/configuracoes.dart';
import 'package:mini_projeto_3/screens/detalhes_lugar.dart';
import 'package:mini_projeto_3/screens/lugares_por_pais.dart';
import 'package:mini_projeto_3/screens/adicionar_lugar.dart';
import 'package:mini_projeto_3/screens/lugares_screen.dart';
import 'package:mini_projeto_3/screens/adicionar_pais.dart';
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
  late PaisesModel model;

  @override
  void initState() {
    super.initState();
    model = PaisesModel();
    model.initialize(); // Certifique-se de que a função initialize() é chamada apenas uma vez aqui
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (ctx) => MinhasAbas(),
          '/adicionarPais' : (ctx) => AdicionarPais(),
          '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
          '/detalheLugar': (ctx) => DetalhesLugarScreen(),
          '/configuracoes': (ctx) => ConfigracoesScreen(),
          '/adicionarLugar': (ctx) => AdicionarLugar(),
          '/lugares': (ctx) => LugaresScreen(),
        },
      ),
    );
  }
}
