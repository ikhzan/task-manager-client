import 'package:flutter/material.dart';
import 'package:task_manager_client/widgets/home_header.dart';
import 'package:task_manager_client/widgets/task_dashboard.dart';
import 'package:task_manager_client/widgets/task_header.dart';
import 'package:task_manager_client/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            HomeHeader(userName: "Mohammad", teamName: "DevOps"),
            SizedBox(height: 10),
            TaskHeader(totalTasks: 10, completedTasks:10),

            TaskDashboard(pendingTasks: 10, completedTasks: 5),
            SizedBox(height: 10),
            Expanded(child: TaskList()),
          ],
        ),
      ),
    );
  }


}