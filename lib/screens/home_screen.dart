import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';

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
      appBar: AppBar(title: Text("Task Manager"),),
      body: FutureBuilder<bool>(
        future: isLoggedIn(), 
        builder: (context,snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          final bool loggedIn = snapshot.data!;
          return Center(
            child: Column(
              children: [
                Text("Welcome to Task Manager", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                SizedBox(height: 16,),
                if(!loggedIn) ...[
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'), 
                    child: Text("Login")
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'), 
                    child: Text("Register")
                  ),
                ],
                if(loggedIn)
                  ElevatedButton(
                    onPressed: _logout, 
                    child: Text("Logout")
                  ),
              ],
            ),
          );
        }
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