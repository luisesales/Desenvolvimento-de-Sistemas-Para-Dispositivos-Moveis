import 'dart:io';

import 'package:minha_agenda_app/model/contact.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailContact extends StatelessWidget {
  final Contact contact;

  const DetailContact({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          "${contact.name} ${contact.surname}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: contact.avatar.path.startsWith('http')
                ? Image.network(
                    contact.avatar.path,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    contact.avatar,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dados',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Row(children: [
                            Icon(Icons.note),
                            Text('Nome'),
                          ]),
                          Text('${contact.name} ${contact.surname}'),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(children: [
                            Icon(Icons.mail_rounded),
                            Text('Email'),
                          ]),
                          Text(contact.email),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(children: [
                            Icon(Icons.call_rounded),
                            Text('Contato'),
                          ]),
                          Text(contact.phone),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ContactList>().favorite(contact);
        },
        child: Icon(Icons.star_border),
      ),
    );
  }
}
