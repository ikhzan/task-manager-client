import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:task_manager_client/commons/constants.dart';
// import 'package:task_manager_client/core/local_storage.dart';
// import 'package:task_manager_client/prepare_screen.dart';
import 'package:task_manager_client/providers/user_provider.dart';
import 'package:task_manager_client/screens/auth/login_screen.dart';
import 'package:task_manager_client/screens/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  // Future<String?> _alreadyDone() async {
  //   return LocalStorage.getData("intro"); // Replace with actual implementation
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}
