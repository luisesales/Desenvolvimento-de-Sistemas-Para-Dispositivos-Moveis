import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minha_agenda_app/model/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:minha_agenda_app/utils/dbUtils.dart';
import 'package:minha_agenda_app/model/position.dart';

class ContactList with ChangeNotifier {
  final int MAX_USERS = 9999;
  final url = "https://minha-agenda-app-c4c32-default-rtdb.firebaseio.com/";
  List<Contact> _contactList = [];
  Contact? _currentContact; // Adicionando o usuário atual

  List<Contact> get contacts {
    return [..._contactList];
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
    void favorite(Contact contact) {
      contact.status != 0
          ? updateContact(contact.id, contact.name, contact.surname,
              contact.email, contact.phone, contact.address!, contact.avatar, 0)
          : updateContact(
              contact.id,
              contact.name,
              contact.surname,
              contact.email,
              contact.phone,
              contact.address!,
              contact.avatar,
              1);
      notifyListeners();
    }
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
      await DbUtil.insert('contacts', {
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
      });
      _contactList.add(newContact);
      notifyListeners();
      return 'Contato adicionado com sucesso!';
    } catch (error) {
      return 'Erro ao adicionar contato: $error';
    }
  }

  Future<String> removeContact(String id) async {
    try {
      await DbUtil.delete('contacts', id);
      _contactList.removeWhere((contact) => contact.id == id);
      notifyListeners();
      return 'Contato removido com sucesso!';
    } catch (error) {
      return 'Erro ao remover contato: $error';
    }
  }

  Future<String> loadContacts() async {
    try {
      final dataList = await DbUtil.getData('contacts');
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
          .toList();
      notifyListeners();
      return 'Contatos carregados com sucesso!';
    } catch (error) {
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
      await DbUtil.update(
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
          id);
      int altId = int.parse(id);
      _contactList.replaceRange(altId, altId, {newContact});
      return 'Produto atualizado com sucesso!';
    } catch (error) {
      return 'Erro ao atualizar contato: $error';
    }
  }
}
