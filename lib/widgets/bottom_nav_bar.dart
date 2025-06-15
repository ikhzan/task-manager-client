import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    else if (index == 1) Navigator.pushReplacementNamed(context, '/tasks');
    else if (index == 2) Navigator.pushNamed(context, '/addTask');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Task"),
      ],
      onTap: _onItemTapped,
    );
  }
}