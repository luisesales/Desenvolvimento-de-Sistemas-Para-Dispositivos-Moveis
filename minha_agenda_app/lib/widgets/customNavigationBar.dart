import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue, // Define a cor de fundo da barra
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.black), label: 'Favorites'),
        BottomNavigationBarItem(
            icon: Icon(Icons.block, color: Colors.black), label: 'Blocked'),
        BottomNavigationBarItem(
            icon: Icon(Icons.plus_one, color: Colors.black),
            label: 'Add Contact')
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white, // cor do ícone selecionado
      unselectedItemColor: Colors.white, // cor dos ícones não selecionados
      onTap: onItemTapped,
    );
  }
}
