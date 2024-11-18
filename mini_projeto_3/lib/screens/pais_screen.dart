import 'package:mini_projeto_3/components/item_pais.dart';
import 'package:mini_projeto_3/components/modal_bottomsheet.dart';
import 'package:mini_projeto_3/model/PaisesModel.dart';
import 'package:mini_projeto_3/model/Pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<PaisesModel>(
            builder: (context, paisesModel, child) {
              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 120,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: paisesModel.todos_paises.length,
                itemBuilder: (context, index) {
                  final pais = paisesModel.todos_paises.elementAt(index);
                  return Card(
                    elevation: 4,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ItemPais(pais: pais),
                        ),
                        Positioned(                          
                          top: 64,
                          right: 32,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                tooltip: "Editar País",
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                                color: Theme.of(context).primaryColor,
                              ),
                              IconButton(
                                tooltip: "Excluir País",
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ModalBottomSheet(
                                      color: Colors.red,
                                      onConditionMet: () {
                                        paisesModel.removePais(pais);
                                        Navigator.pop(context); // Fecha o modal bottom sheet
                                        final snackBar = SnackBar(
                                          content: Text('${pais.titulo} foi deletado com Sucesso!'),
                                          action: SnackBarAction(
                                            label: '',
                                            onPressed: () {},
                                          ),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      confirmAction: "Excluir",
                                      confirmLabel: "Tem certeza de que deseja excluir ${pais.titulo}?",
                                      confirmTitle: "Confirmação de Exclusão",
                                    );
                                  },
                                ),
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/adicionarPais',
                  arguments: () {
                    final snackBar = SnackBar(
                      content: Text('País adicionado com Sucesso!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
              tooltip: 'Adicionar País',
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
