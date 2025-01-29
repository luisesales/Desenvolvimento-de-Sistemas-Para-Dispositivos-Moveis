import 'package:flutter/material.dart';
import 'package:minha_agenda_app/pages/blocked.dart';
import 'package:minha_agenda_app/pages/createContact.dart';
import 'package:minha_agenda_app/pages/favorites.dart';
import 'package:minha_agenda_app/pages/HomeContent.dart';
import 'package:minha_agenda_app/widgets/CustomNavigationBar.dart';
import 'package:minha_agenda_app/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/utils/routes.dart';

class ManageContacts extends StatefulWidget {
  const ManageContacts({super.key});

  @override
  _ManageContactsState createState() => _ManageContactsState();
}

class _ManageContactsState extends State<ManageContacts> {
  int _selectedIndex = 0; // índice selecionado no BottomNavigationBar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obter o nome de usuário a partir do Provider

    List<Widget> _pages = [
      HomeContent(
        manage: true,
      ),
      Favorites(
        manage: true,
      ),
      Blocked(manage: true)
    ];

    if (_selectedIndex == 0 || _selectedIndex == 2) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(
            "Gerenciar Contatos",
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: MyDrawer(),
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
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          "Gerenciar Contatos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(),
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
