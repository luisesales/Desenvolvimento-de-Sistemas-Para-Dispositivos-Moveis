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
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: Position(
          latitude: json['latitude'] as double,
          longitude: json['longitude'] as double,
          address: json['address'] as String),
      avatar: File(json['avatar'] as String),
      status: json['status'] as int ?? 0,
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
      'avatar': avatar.path,
      'status': status
    };
    return data;
  }
}
