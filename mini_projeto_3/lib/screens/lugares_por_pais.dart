import 'package:mini_projeto_3/components/item_lugar.dart';
import 'package:mini_projeto_3/data/dados.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/model/pais.dart';
import 'package:flutter/material.dart';

class LugarPorPaisScreen extends StatelessWidget {
  
  LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final pais = ModalRoute.of(context)?.settings.arguments as Pais;
    
    //prepara a lista de lugares por pais
    final List<Lugar> lugaresPorPais = lugares.where((lugar) {
      return lugar.paises.contains(pais.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
         backgroundColor: pais.cor,
        title: Text(
          "Lugares em ${pais.titulo}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: lugaresPorPais.length,
        itemBuilder: (context, index) {
          return ItemLugar(lugar: lugaresPorPais.elementAt(index));
        },
      ),
    );
  }
}
