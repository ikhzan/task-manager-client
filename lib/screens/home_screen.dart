import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/widgets/basic_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> isLoggedIn() async{
    return await LocalStorage.isUserLoggedIn();
  }

  void _logout() async{
    await LocalStorage.setUserLoggedIn(false);
    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.deepPurpleAccent,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your today's task almost here", style: TextStyle(color: Colors.white, fontSize: 16),),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          child: Text('View Task'),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("In Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            Row(children: [
              
            ],)
          ],
        ),
      ),
    );
  }
}

class FeatureList extends StatelessWidget{
  const FeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 24), 
      child: Column(
        children: [
          FeatureItem(icon: Icons.task_alt, title: "Manage tasks efficiently"),
          FeatureItem(icon: Icons.group, title:"Collaborate with teams"),
          FeatureItem(icon: Icons.priority_high, title: "Set Priorities & deadlines"),
          FeatureItem(icon: Icons.analytics, title: "Track task progress"),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget{
  final IconData icon;
  final String title;

  const FeatureItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 28, color: Colors.blue,),
        SizedBox(width: 10,),
        Text(title, style: TextStyle(fontSize: 16),)
      ],
    );
  }
}