import 'package:minha_agenda_app/model/contact.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/widgets/modalBottomSheet.dart';
import 'package:minha_agenda_app/widgets/contactCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blocked extends StatefulWidget {
  Blocked({super.key});

  @override
  _BlockedState createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> {
  @override
  void initState() {
    final response = Provider.of<ContactList>(context).loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Contact> contactList =
        Provider.of<ContactList>(context).contacts;

    return Stack(children: [
      ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        tooltip: "Editar Contato",
                        onPressed: () {},
                        color: ThemeData().primaryColor,
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        tooltip: "Excluir Contato",
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ModalBottomSheet(
                              color: Colors.red,
                              onConditionMet: () {
                                context.read<ContactList>().removeContact(
                                    contactList.elementAt(index).id);
                                Navigator.pop(
                                    context); // Fecha o modal bottom sheet
                                final snackBar = SnackBar(
                                  content: Text(
                                      '${contactList.elementAt(index).name} ${contactList.elementAt(index).surname} foi deletado com Sucesso!'),
                                  action: SnackBarAction(
                                    label: '',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              confirmAction: "Excluir",
                              confirmLabel:
                                  "Tem certeza de que deseja excluir ${contactList.elementAt(index).name} ${contactList.elementAt(index).surname}?",
                              confirmTitle: "Confirmação de Exclusão",
                            );
                          },
                        ),
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
                ContactCard(contact: contactList.elementAt(index)),
              ],
            ),
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
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/adicionarContato',
                  arguments: () {
                    final snackBar = SnackBar(
                      content: Text('Contato adicionado com Sucesso!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
              tooltip: 'Adicionar Contato',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    ]);
  }
}
