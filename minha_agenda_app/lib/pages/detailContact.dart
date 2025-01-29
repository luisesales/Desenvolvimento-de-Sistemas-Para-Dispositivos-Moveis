import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minha_agenda_app/model/contact.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:provider/provider.dart';

class DetailContact extends StatefulWidget {
  final Contact contact;

  const DetailContact({
    super.key,
    required this.contact,
  });

  @override
  _DetailContactState createState() => _DetailContactState();
}

class _DetailContactState extends State<DetailContact> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          "${widget.contact.name} ${widget.contact.surname}",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                '/update-contact',
                arguments: widget.contact,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: widget.contact.avatar.path.startsWith('http')
                  ? NetworkImage(widget.contact.avatar.path)
                  : FileImage(widget.contact.avatar) as ImageProvider,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Dados',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 350,
              height: 450,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.note),
                          SizedBox(width: 8),
                          Text('Nome'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text('${widget.contact.name} ${widget.contact.surname}'),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.mail_rounded),
                          SizedBox(width: 8),
                          Text('Email'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(widget.contact.email),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.call_rounded),
                          SizedBox(width: 8),
                          Text('Contato'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(widget.contact.phone),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.pin_drop_rounded),
                          SizedBox(width: 8),
                          Text('Endereço'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(widget.contact.address!.address),
                      Row(
                        children: [
                          Icon(Icons.pin_drop_rounded),
                          SizedBox(width: 8),
                          Text('Latitude'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(widget.contact.address!.latitude.toString()),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.pin_drop_rounded),
                          SizedBox(width: 8),
                          Text('Longitude'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(widget.contact.address!.longitude.toString()),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.mode_comment_rounded),
                          SizedBox(width: 8),
                          Text('Status'),
                        ],
                      ),
                      SizedBox(height: 4),
                      ReturnStatusText(widget.contact.status),
                      SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            left: 60,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  context.read<ContactList>().block(widget.contact);
                });
              },
              child: Icon(Icons.block_outlined),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  context.read<ContactList>().favorite(widget.contact);
                });
              },
              child: Icon(Icons.star_border),
            ),
          ),
        ],
      ),
    );
  }
}
