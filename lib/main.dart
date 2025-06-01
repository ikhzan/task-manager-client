import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/routes/app_route.dart';
import 'package:task_manager_client/screens/add_task_screen.dart';
import 'package:task_manager_client/screens/home_screen.dart';
import 'package:task_manager_client/screens/login_screen.dart';
import 'package:task_manager_client/screens/register_screen.dart';
import 'package:task_manager_client/screens/task_list_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // final username = await LocalStorage.getUsername();

  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomeScreen(),
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/tasks': (context) => TaskListScreen(),
      '/addTask': (context) => AddTaskScreen()
    },
  ));

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



