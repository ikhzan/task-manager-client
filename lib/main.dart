import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/routes/app_route.dart';
import 'package:task_manager_client/screens/add_task_screen.dart';
import 'package:task_manager_client/screens/home_screen.dart';
import 'package:task_manager_client/screens/kpi_screen.dart';
import 'package:task_manager_client/screens/login_screen.dart';
import 'package:task_manager_client/screens/main_screen.dart';
import 'package:task_manager_client/screens/register_screen.dart';
import 'package:task_manager_client/screens/task_list_screen.dart';
import 'package:task_manager_client/screens/task_screen.dart';
import 'package:task_manager_client/screens/team_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isLoggedIn = await LocalStorage.isUserLoggedIn();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: isLoggedIn ? MainScreen() : LoginScreen(),
      home: MainScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/tasks': (context) => TaskScreen(),
        '/addTask': (context) => AddTaskScreen(),
        '/teams': (context) => TeamScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
         '/kpi': (context) => KpiScreen(),
      },
    ),
  );
}

class TaskManagerApp extends StatelessWidget {
  final Widget startScreen;
  const TaskManagerApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: startScreen,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: AppRoute.routes,
    );
  }
}
