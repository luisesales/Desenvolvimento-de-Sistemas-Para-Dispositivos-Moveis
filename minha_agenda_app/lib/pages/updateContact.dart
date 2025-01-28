import 'dart:io';
import 'dart:math';

import 'package:minha_agenda_app/model/position.dart';
import 'package:minha_agenda_app/widgets/imageInput.dart';
import 'package:minha_agenda_app/widgets/positionInput.dart';
import 'package:minha_agenda_app/model/contact.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({super.key});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  File? _pickedImage;
  Position? _currPosition;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePosition(Position currPosition) {
    _currPosition = currPosition;
  }

  void _submitForm() async {
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _pickedImage == null ||
        _currPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
        ),
      );
      return;
    }

    try {
      // Salvar localmente
      Provider.of<ContactList>(context, listen: false).addContact(
          _nameController.text,
          _surnameController.text,
          _phoneController.text,
          _emailController.text,
          Position(
            latitude: _currPosition!.latitude,
            longitude: _currPosition!.longitude,
            address: _currPosition!.address,
          ),
          _pickedImage!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PContato salvo com sucesso!')),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false, // Remove todas as rotas anteriores
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o contato: $error')),
      );
      print("$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Contato',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Crie um novo contato na agenda!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome do contato',
                  prefixIcon: Icon(Icons.title, color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _surnameController,
                decoration: InputDecoration(
                  labelText: 'Sobrenome do contato',
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              const Text(
                'Adicione um avatar ao seu contato',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 4),
              ImageInput(_selectImage),
              const SizedBox(height: 20),
              const Text(
                'Localização',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 4),
              PositionInput(_savePosition),
              const SizedBox(height: 20),
              const Text(
                'Informações gerais',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF616161),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: '(DDD) 90000-0000',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Criar Contato',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
