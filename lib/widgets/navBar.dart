import 'package:flutter/material.dart';

BottomNavigationBar navBar() {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
  }

  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.gamepad),
        label: 'Game',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.query_stats),
        label: 'history',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        backgroundColor: Colors.blue,
      ),
    ],
    currentIndex: selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: onItemTapped,
  );
}
