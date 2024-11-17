import 'package:mini_projeto_3/components/item_pais.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "Países",
          style: TextStyle(color: Colors.white),
        ),
      ), */
      body: Stack(children: [
        Consumer<PaisesModel>(        
          builder: (context, paisesModel, child) {
            return GridView(
            padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 120,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                
              ),
              children: paisesModel.todos_paises.map((pais) => ItemPais(pais: pais)).toList(),
            );
          }
        ),
      Positioned( 
          bottom: 16, 
          right: 16, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () { Navigator.of(context).pushNamed('/adicionarPais'); },
                tooltip: 'Adicionar Lugar',
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ]),      
    );
  }
}
