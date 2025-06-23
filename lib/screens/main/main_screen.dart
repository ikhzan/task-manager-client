import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/screens/auth/login_screen.dart';
import 'package:task_manager_client/screens/home/home_screen.dart';
import 'package:task_manager_client/screens/kpi/kpi_screen.dart';
import 'package:task_manager_client/screens/profile/profile_screen.dart';
import 'package:task_manager_client/screens/tasks/task_screen.dart';
import 'package:task_manager_client/screens/team/team_screen.dart';
import 'package:task_manager_client/services/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Future<String?>? _fullNameFuture;

  final List<Widget> _screens = [
    HomeScreen(),
    TaskScreen(),
    TeamScreen(),
    KpiScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fullNameFuture = LocalStorage.getData(Constants.fullName);
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _logout(BuildContext context) async {
    await AuthService().logout();
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hallo', style: TextStyle(fontSize: 13)),
            FutureBuilder<String?>(
              future: _fullNameFuture,
              builder: (context, snapshot) {
                final name = snapshot.data ?? 'no data';
                return Text(
                  name,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                );
              },
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen(),
              ),
            );
          },
          icon: Icon(Icons.supervised_user_circle, size: 50),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: "Team",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Kpi"),
          ],
        ),
      ),
    );
  }
}
