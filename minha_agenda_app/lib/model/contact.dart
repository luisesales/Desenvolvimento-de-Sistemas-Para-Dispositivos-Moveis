import 'package:flutter/material.dart';
import 'dart:io';

import 'package:minha_agenda_app/model/position.dart';

class Contact with ChangeNotifier {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final Position? address;
  final File avatar;
  final int status;

  Contact({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    this.address,
    required this.avatar,
    required this.status,
  });

  Contact.fromContact(Contact contact)
      : id = contact.id,
        name = contact.name,
        surname = contact.surname,
        email = contact.email,
        phone = contact.phone,
        address = Position(
            latitude: contact.address!.latitude,
            longitude: contact.address!.latitude,
            address: contact.address!.address),
        avatar = contact.avatar,
        status = contact.status;

  factory Contact.fromJson(String id, Map<String, dynamic> json) {
    return Contact(
      id: id,
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
      address: Position(
          latitude: json['latitude'],
          longitude: json['longitude'],
          address: json['address']),
      avatar: json['avatar'],
      status: json['status'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'address': address!.address,
      'latitude': address!.latitude,
      'longitude': address!.longitude,
      'avatar': avatar,
      'status': status
    };
    return data;
  }
}
