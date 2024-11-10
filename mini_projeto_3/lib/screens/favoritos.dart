import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/components/item_lugar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoritosScreen extends StatelessWidget {  
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaisesModel>( builder: (context, paisesModel, child) {
      if (paisesModel.favoritos.isEmpty) {
        return const Center(
          child: Text('Nenhum Lugar Marcado como Favorito!', style: TextStyle(fontSize: 20),),
        );
      } else {
        return ListView.builder(
            itemCount: paisesModel.favoritos.length,
            itemBuilder: (ctx, index) {
              return ItemLugar(lugar: paisesModel.favoritos.elementAt(index));
            });
      }
    });
  }
}