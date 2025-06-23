import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/screens/auth/login_screen.dart';
import 'package:task_manager_client/screens/main/main_screen.dart';

class PrepareScreen extends StatelessWidget {
  const PrepareScreen({super.key});

  Future<String?> _getUsernameFromLocalStorage() async {
    return LocalStorage.getData(
      Constants.username,
    ); // Replace with actual implementation
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUsernameFromLocalStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return MainScreen();
        } else {
          return Scaffold(
            appBar: AppBar(title: Text('Task Manager'), leading: Icon(Icons.notification_important, color: Colors.lightBlue,),),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Being in best performance make your employee happier, clients happier',style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Evaluate your performance by checking your task management',
                    ),
                    SizedBox(child: Image(image: AssetImage('assets/intro/slide-1.png')),),
                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
