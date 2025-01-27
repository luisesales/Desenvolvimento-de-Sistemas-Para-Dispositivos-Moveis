import 'package:flutter/material.dart';
import 'package:minha_agenda_app/pages/createContact.dart';
import 'package:minha_agenda_app/widgets/CustomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:minha_agenda_app/model/contactList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // índice selecionado no BottomNavigationBar
  DateTime? weddingDate; // Variável para armazenar a data do casamento

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obter o nome de usuário a partir do Provider
    final contactList = Provider.of<ContactList>(context);

    List<Widget> _pages = [];

    if (_selectedIndex == 0 || _selectedIndex == 2) {
      return Scaffold(
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      );
    }
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
