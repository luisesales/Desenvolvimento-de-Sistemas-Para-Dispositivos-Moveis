import 'package:minha_agenda_app/model/contact.dart';

class UpdateContactArguments {
  final Contact contact;
  final bool manage;

  UpdateContactArguments({
    required this.contact,
    required this.manage,
  });
}
