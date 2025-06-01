import 'package:flutter/material.dart';
// import 'package:task_manager_client/widgets/home_header.dart';
// import 'package:task_manager_client/widgets/task_dashboard.dart';
// import 'package:task_manager_client/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to Task Manager", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          SizedBox(height: 16,),
          // show features of the app
          FeatureList(),

          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'), 
            child: Text('Login')
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'), 
            child: Text('Register')
          )
        ],
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