import 'dart:io';

import 'package:minha_agenda_app/model/contact.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final Contact contact;

  Text ReturnStatusText(int status) {
    if (status == 1) {
      return Text(style: TextStyle(color: Colors.green), "NORMAL");
    } else if (status == 2) {
      return Text(style: TextStyle(color: Colors.blue), "FAVORITO");
    } else {
      return Text(style: TextStyle(color: Colors.red), "BLOQUEADO");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/Contact',
          arguments: contact,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                //bordas na imagem
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: contact.avatar.toString().startsWith('http')
                    ? Image.network(
                        contact.avatar.toString(),
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        contact.avatar,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                //só funciona no contexto do Stack - posso posicionar o elemento
                right: 10,
                bottom: 20,
                child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${contact.name} ${contact.surname}",
                          style: TextStyle(fontSize: 26, color: Colors.white),
                          softWrap: true, //quebra de lina
                          overflow: TextOverflow.fade, //case de overflow
                        ),
                      ],
                    )),
              )
            ]),
            //Text(place.titulo),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.call_rounded),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${contact.phone}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.email_rounded),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${contact.email}')
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.call_rounded),
                      SizedBox(
                        width: 6,
                      ),
                      ReturnStatusText(contact.status)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
