import 'package:mini_projeto_3/components/item_lugar.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:flutter/material.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Lugar> lugaresFavoritos;
  const FavoritosScreen({super.key, required this.lugaresFavoritos});

  @override
  Widget build(BuildContext context) {
    if (lugaresFavoritos.isEmpty) {
      return const Center(
        child: Text('Nenhum Lugar Marcado como Favorito!', style: TextStyle(fontSize: 20),),
      );
    } else {
      return ListView.builder(
          itemCount: lugaresFavoritos.length,
          itemBuilder: (ctx, index) {
            return ItemLugar(lugar: lugaresFavoritos.elementAt(index),);
          });
    }
  }
}