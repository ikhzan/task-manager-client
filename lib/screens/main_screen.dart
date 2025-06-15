

import 'package:flutter/material.dart';
import 'package:task_manager_client/screens/add_task_screen.dart';
import 'package:task_manager_client/screens/home_screen.dart';
import 'package:task_manager_client/screens/task_list_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>{
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    HomeScreen(),
    TaskListScreen(),
    AddTaskScreen()
  ];

  void _onItemTapped(int index){
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Task"),
        ],
      ),
    );
  }
}

