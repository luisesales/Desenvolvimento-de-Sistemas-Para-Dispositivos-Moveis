import 'dart:io';

import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalhesLugarScreen extends StatelessWidget {
  final Lugar lugar;

  const DetalhesLugarScreen({
    super.key,
    required this.lugar,
    });

  @override
  Widget build(BuildContext context) {        

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          lugar.titulo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: lugar.imagemUrl.startsWith('http')
            ? Image.network(
                lugar.imagemUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(lugar.imagemUrl),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dicas',
              style: ThemeData().textTheme.displayLarge,
            ),
          ),
          Container(
            width: 350,
            height: 300,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
                itemCount: lugar.recomendacoes.length,
                itemBuilder: (contexto, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(lugar.recomendacoes[index]),
                        subtitle: Text(lugar.titulo),
                        onTap: () {
                          print(lugar.recomendacoes[index]);
                        },
                      ),
                      Divider(),
                    ],
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){context.read<PaisesModel>().favorite(lugar);},
        child: Icon(Icons.star_border),
      ),
    );
  }
}
