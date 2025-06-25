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
            // appBar: AppBar(title: Text('Task Manager'), leading: Icon(Icons.notification_important, color: Colors.lightBlue,),),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage('assets/intro/slide-1.png'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Being in best performance make your employee happier, clients happier',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Evaluate your performance by checking your task management',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                        ),
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
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            side: BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 2,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurpleAccent,
                        ),
                        onPressed: () {},
                        child: Text('Sign Up'),
                      ),
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
