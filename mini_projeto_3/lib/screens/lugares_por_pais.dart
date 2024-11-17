import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/components/item_lugar.dart';
import 'package:mini_projeto_3/data/dados.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/model/pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LugarPorPaisScreen extends StatelessWidget {
  final pais;

  LugarPorPaisScreen({
    super.key,
    required this.pais,
    });

  @override
  Widget build(BuildContext context) {
    
    
    //prepara a lista de lugares por pais
    final List<Lugar> lugaresPorPais = Provider.of<PaisesModel>(context).getLugares(pais.id);

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
