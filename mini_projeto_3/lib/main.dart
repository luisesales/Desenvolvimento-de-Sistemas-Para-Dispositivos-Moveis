import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/model/pais.dart';
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
    model.initialize(); 
  }

  // Função de callback para ser passada
  void onCountryAdded(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('País adicionado com Sucesso!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          // Verifique o nome da rota
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (ctx) => MinhasAbas());
            case '/adicionarPais':
              final VoidCallback? onCountryAddedCallback = settings.arguments as VoidCallback?;
              return MaterialPageRoute(
                builder: (ctx) => AdicionarPais(onCountryAdded: onCountryAddedCallback),
              );
            case '/lugaresPorPais':
              final pais = settings.arguments as Pais;
              return MaterialPageRoute(builder: (ctx) => LugarPorPaisScreen(pais: pais));
            case '/detalheLugar':
              final lugar = settings.arguments as Lugar;
              return MaterialPageRoute(builder: (ctx) => DetalhesLugarScreen(lugar: lugar));
            case '/configuracoes':
              return MaterialPageRoute(builder: (ctx) => ConfigracoesScreen());
            case '/adicionarLugar':
              final VoidCallback? onPlaceAddedCallback = settings.arguments as VoidCallback?;
              return MaterialPageRoute(builder: (ctx) => AdicionarLugar(onPlaceAdded: onPlaceAddedCallback));
            case '/lugares':
              return MaterialPageRoute(builder: (ctx) => LugaresScreen());
            default:
              return null;
          }
        },
      ),
    );
  }
}
