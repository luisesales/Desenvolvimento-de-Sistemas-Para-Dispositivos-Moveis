import 'package:mini_projeto_3/components/drawer.dart';
import 'package:flutter/material.dart';

class ConfigracoesScreen extends StatelessWidget {
  const ConfigracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
      ),
      drawer: MeuDrawer(),
      body: Center(
        child: Text(
          "Configurações",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
