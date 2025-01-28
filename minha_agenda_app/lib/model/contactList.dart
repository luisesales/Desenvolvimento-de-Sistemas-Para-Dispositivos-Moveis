import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minha_agenda_app/model/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:minha_agenda_app/utils/dbUtils.dart';
import 'package:minha_agenda_app/model/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ContactList with ChangeNotifier {
  final int MAX_USERS = 9999;
  final _baseUrl =
      "https://minha-agenda-app-c4c32-default-rtdb.firebaseio.com/";
  List<Contact> _contactList = [];
  List<Contact> _favorites = [];
  List<Contact> _blocked = [];
  Contact? _currentContact; // Adicionando o usuário atual

  List<Contact> get contacts {
    return [..._contactList];
  }

  List<Contact> get favorites {
    return [..._favorites];
  }

  List<Contact> get blocked {
    return [..._blocked];
  }

  Contact? get currentContact => _currentContact;

  void setCurrentContact(Contact contact) {
    _currentContact = contact;
    notifyListeners();
  }

  void favorite(Contact contact) {
    contact.status != 2
        ? updateContact(contact.id, contact.name, contact.surname,
            contact.email, contact.phone, contact.address!, contact.avatar, 2)
        : updateContact(contact.id, contact.name, contact.surname,
            contact.email, contact.phone, contact.address!, contact.avatar, 1);
    notifyListeners();
  }

  void block(Contact contact) {
    contact.status != 0
        ? updateContact(contact.id, contact.name, contact.surname,
            contact.email, contact.phone, contact.address!, contact.avatar, 0)
        : updateContact(contact.id, contact.name, contact.surname,
            contact.email, contact.phone, contact.address!, contact.avatar, 1);
    notifyListeners();
  }

// parâmetro de localização adicionado
  Future<String> addContact(String name, String surname, String email,
      String phone, Position address, File avatar) async {
    final newContact = Contact(
        id: Random().nextInt(MAX_USERS).toString(),
        name: name,
        surname: surname,
        email: email,
        phone: phone,
        address: address,
        avatar: avatar,
        status: 1);

    try {
      /*await DbUtil.insert('contacts', {
        'id': newContact.id,
        'name': newContact.name,
        'surname': newContact.surname,
        'email': newContact.email,
        'phone': newContact.phone,
        'address': newContact.address!.address,
        'latitude': newContact.address!.latitude,
        'longitude': newContact.address!.longitude,
        'avatar': newContact.avatar.path,
        'status': newContact.status
      });*/

      var response = await http.post(Uri.parse('$_baseUrl/contacts.json'),
          body: jsonEncode(newContact.toJson()));

      print("Codigo ${response.statusCode} \n\n");
      print("Corpo ${response.body} \n\n");

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)['name'];
        _contactList.add(newContact);
        notifyListeners();
      } else {
        print("\n\nAconteceu algum erro na requisição ${response}\n\n");
        throw Exception("Aconteceu algum erro na requisição");
      }

      return 'Contato adicionado com sucesso!';
    } catch (error) {
      print('\n\nErro ao adicionar contato: $error\n\n\n');
      return 'Erro ao adicionar contato: $error';
    }
  }

  Future<String> removeContact(String id) async {
    try {
      //await DbUtil.delete('contacts', id);
      final response =
          await http.delete(Uri.parse('$_baseUrl/contacts/${id}.json'));

      print("Codigo ${response.statusCode} \n\n");
      print("Corpo ${response.body} \n\n");

      if (response.statusCode == 200) {
        _contactList.removeWhere((contact) => contact.id == id);
        notifyListeners();
        return 'Contato removido com sucesso!';
      } else {
        print("\n\nAconteceu algum erro na requisição ${response}\n\n");
        throw Exception("Aconteceu algum erro durante a requisição");
      }
    } catch (error) {
      print('\n\nErro ao remover contato: $error \n\n\n');
      return 'Erro ao remover contato: $error';
    }
  }

  Future<String> loadContacts() async {
    try {
      /*final dataList = await DbUtil.getData('contacts');
      _contactList = dataList
          .map(
            (item) => Contact(
                id: item['id'],
                name: item['name'],
                surname: item['surname'],
                email: item['email'],
                phone: item['phone'],
                avatar: File(item['avatar']),
                address: Position(
                  latitude: item['latitude'],
                  longitude: item['longitude'],
                  address: item['address'],
                ),
                status: item['status']),
          )
          .toList();*/
      List<Contact> contacts = [];
      final response = await http.get(Uri.parse('$_baseUrl/contacts.json'));
      print("Codigo ${response.statusCode} \n\n");
      print("Corpo ${response.body} \n\n");

      if (response.statusCode == 200) {
        if (response.body != "null") {
          Map<String, dynamic> _productsJson = jsonDecode(response.body);
          _productsJson.forEach((id, contact) {
            contacts.add(Contact.fromJson(id, contact));
          });
          _contactList = contacts;
          notifyListeners();
        }
        print('\n\nContatos carregados com sucesso!\n\n\n');
        return 'Contatos carregados com sucesso!';
      } else {
        print("\n\nAconteceu algum erro na requisição ${response}\n\n");
        return "Aconteceu algum erro na requisição";
      }
    } catch (error) {
      print('\n\nErro ao recuperar contatos: $error\n\n\n');
      return 'Erro ao recuperar contatos: $error';
    }
  }

  Future<String> updateContact(
    String id,
    String name,
    String surname,
    String email,
    String phone,
    Position address,
    File avatar,
    int status,
  ) async {
    final newContact = Contact(
        id: id,
        name: name,
        surname: surname,
        email: email,
        phone: phone,
        address: address,
        avatar: avatar,
        status: status);

    try {
      /*await DbUtil.update(
          'contacts',
          {
            'name': newContact.name,
            'surname': newContact.surname,
            'email': newContact.email,
            'phone': newContact.phone,
            'address': newContact.address!.address,
            'latitude': newContact.address!.latitude,
            'longitude': newContact.address!.longitude,
            'avatar': newContact.avatar.path,
            'status': newContact.status
          },
          id);*/
      var response = await http.put(Uri.parse('$_baseUrl/contacts/${id}.json'),
          body: jsonEncode(newContact.toJson()));

      print("Codigo ${response.statusCode} \n\n");
      print("Corpo ${response.body} \n\n");

      if (response.statusCode == 200) {
        _contactList.removeWhere((contact) => contact.id == id);
        _contactList.add(newContact);
        notifyListeners();
        print('\n\nContato atualizado com sucesso!\n\n\n');
        return '\n\nContato atualizado com sucesso!\n\n\n';
      } else {
        print("\n\nAconteceu algum erro na requisição ${response}\n\n");
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (error) {
      print('\n\nErro ao atualizar contato: $error\n\n\n');
      return 'Erro ao atualizar contato: $error';
    }
  }
}
