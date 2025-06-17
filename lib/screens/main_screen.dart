

import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/screens/home_screen.dart';
import 'package:task_manager_client/screens/kpi_screen.dart';
import 'package:task_manager_client/screens/task_list_screen.dart';
import 'package:task_manager_client/screens/task_screen.dart';
import 'package:task_manager_client/screens/team_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>{
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    HomeScreen(),
    TaskScreen(),
    TeamScreen(),
    KpiScreen()
  ];

  void _onItemTapped(int index){
    setState(() => _selectedIndex = index);
  }

  void _logout() async{
    await LocalStorage.setUserLoggedIn(false);
    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hallo', style: TextStyle(fontSize: 13)),
            Text('Mohammad Ikhsan'),
          ],
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.supervised_user_circle, size: 50),
        ),
        actions:  [ 
          IconButton(onPressed: _logout, icon: Icon(Icons.logout))
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 30.0,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: "Team"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Kpi"),
        ],
      ),
    );
  }
}

