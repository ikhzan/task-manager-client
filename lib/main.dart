import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/routes/app_route.dart';
import 'package:task_manager_client/screens/home_screen.dart';
import 'package:task_manager_client/screens/login_screen.dart';


// void main() {
//    runApp(
//     ChangeNotifierProvider(
//       create: (context) => TaskProvider(),
//       child: MyApp(),
//     ),
//   );

// }



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final username = await LocalStorage.getUsername();
  runApp(MaterialApp(home: username == null ? LoginScreen() : HomeScreen()));
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



