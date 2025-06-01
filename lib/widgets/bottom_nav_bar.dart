import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Task"),
      ],
      onTap: (index) {
        if (index == 0) Navigator.pushReplacementNamed(context, '/home');
        else if (index == 1) Navigator.pushReplacementNamed(context, '/tasks');
        else if (index == 2) Navigator.pushNamed(context, '/addTask');
      },
    );
  }

}