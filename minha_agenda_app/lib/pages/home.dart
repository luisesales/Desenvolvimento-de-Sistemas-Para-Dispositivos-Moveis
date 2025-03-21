import 'package:flutter/material.dart';
import 'package:minha_agenda_app/pages/blocked.dart';
import 'package:minha_agenda_app/pages/createContact.dart';
import 'package:minha_agenda_app/pages/favorites.dart';
import 'package:minha_agenda_app/pages/homeContent.dart';
import 'package:minha_agenda_app/widgets/CustomNavigationBar.dart';
import 'package:minha_agenda_app/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:minha_agenda_app/model/contactList.dart';
import 'package:minha_agenda_app/utils/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        manage: false,
      ),
      Favorites(
        manage: false,
      ),
      Blocked(manage: false)
    ];

    if (_selectedIndex == 0 || _selectedIndex == 2) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(
            "Visualizar Contatos",
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
          "Visualizar Contatos",
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
