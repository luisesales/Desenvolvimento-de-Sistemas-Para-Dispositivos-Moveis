import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/components/item_lugar.dart';
import 'package:mini_projeto_3/components/modal_bottomsheet.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LugaresScreen extends StatelessWidget {
  
  LugaresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //prepara a lista de lugares por pais
    final List<Lugar> lugaresPorPais = context.watch<PaisesModel>().todos_lugares;

    return Scaffold(
      appBar: AppBar(       
        backgroundColor: ThemeData().primaryColor,  
        title: Text(
          "Lugares",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MeuDrawer(),
      body: Stack(children: [
        ListView.builder(
          itemCount: lugaresPorPais.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top:24),
              child: Column(
                children: [ 
                  Row(                                    
                    children: [
                      Expanded(
                        flex: 2, 
                        child: IconButton(
                          tooltip: "Editar Lugar",
                          onPressed: (){},
                          color:  ThemeData().primaryColor,
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      Spacer(flex: 1,),

                      Expanded(
                        flex: 2,
                        child: IconButton(
                          tooltip: "Excluir Lugar",
                          onPressed: () => ModalBottomSheet(
                                            color: Colors.red,
                                            onConditionMet: (){context.read<PaisesModel>().removeLugar(lugaresPorPais.elementAt(index));},
                                            confirmAction: "Excluir",
                                            confirmLabel: "Tem certeza de que deseja excluir ${lugaresPorPais.elementAt(index).titulo}",    
                                            confirmTitle: "Confirmação de Exclusão",
                                          ),  
                          color: Colors.red,                     
                          icon: Icon(Icons.delete)
                        ),
                      ),
                  ],),
                  ItemLugar(lugar: lugaresPorPais.elementAt(index)),
              ],)
            );
          },  
        ),
        Positioned( 
          bottom: 16, 
          right: 16, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: (){Navigator.of(context).pushNamed('/adicionarLugar');},
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
