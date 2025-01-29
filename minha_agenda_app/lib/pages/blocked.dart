import 'package:flutter/material.dart';
import 'package:minha_agenda_app/model/contact.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/widgets/contactCard.dart';
import 'package:minha_agenda_app/widgets/modalBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:minha_agenda_app/pages/updateContact.dart';

class Blocked extends StatefulWidget {
  final bool manage;
  Blocked({super.key, required this.manage});

  @override
  _BlockedState createState() => _BlockedState();
}

class _BlockedState extends State<Blocked> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FutureBuilder(
        future: Provider.of<ContactList>(context, listen: false).loadContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<ContactList>(
              builder: (ctx, contactList, child) {
                final List<Contact> filteredContactList = contactList.contacts
                    .where((contact) => contact.status == 0)
                    .toList();
                return ListView.builder(
                  itemCount: filteredContactList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          widget.manage
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: IconButton(
                                        tooltip: "Editar Contato",
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            '/update-contact',
                                            arguments: filteredContactList
                                                .elementAt(index),
                                          );
                                        },
                                        color: Theme.of(context).primaryColor,
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
                                                context
                                                    .read<ContactList>()
                                                    .removeContact(
                                                        filteredContactList
                                                            .elementAt(index)
                                                            .id);
                                                Navigator.pop(context);
                                                final snackBar = SnackBar(
                                                  content: Text(
                                                      '${filteredContactList.elementAt(index).name} ${filteredContactList.elementAt(index).surname} foi deletado com Sucesso!'),
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
                                                  "Tem certeza de que deseja excluir ${filteredContactList.elementAt(index).name} ${filteredContactList.elementAt(index).surname}?",
                                              confirmTitle:
                                                  "Confirmação de Exclusão",
                                            );
                                          },
                                        ),
                                        color: Colors.red,
                                        icon: Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          ContactCard(
                              contact: filteredContactList.elementAt(index)),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      Positioned(
        bottom: 16,
        right: 16,
        child: widget.manage
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/input-contact',
                        arguments: () {
                          final snackBar = SnackBar(
                            content: Text('Contato adicionado com sucesso!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      );
                    },
                    tooltip: 'Adicionar Contato',
                    child: Icon(Icons.add),
                  ),
                ],
              )
            : Container(),
      ),
    ]);
  }
}
