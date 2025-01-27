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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
            backgroundColor: Colors.brown),
        BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.black),
            label: 'Favorites',
            backgroundColor: Colors.brown),
        BottomNavigationBarItem(
            icon: Icon(Icons.block, color: Colors.black),
            label: 'Blocked',
            backgroundColor: Colors.brown),
        BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.black),
            label: 'New Contact',
            backgroundColor: Colors.brown)
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      onTap: onItemTapped,
    );
  }
}
