
import 'package:flutter/material.dart';
import 'package:task_manager_client/models/task_model.dart';
import 'package:task_manager_client/services/task_service.dart';
import 'package:task_manager_client/widgets/task_header.dart';
import 'package:task_manager_client/widgets/task_list.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();

}

class _TaskListScreenState extends State<TaskListScreen>{
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task List"), leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: FutureBuilder<List<Task>> (
            future: TaskService().fetchTasks(), 
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                return Center(child: Text("Error Loading Task"),);
              }else{
                final tasks = snapshot.data!;
                return Column(
                  children: [
                    TaskHeader(totalTasks: tasks.length, completedTasks: tasks.where((t) => t.completed).length),
                    Expanded(child: TaskList(tasks: tasks))
                  ],
                ); 
              }
            }
          ),
        
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addTask'),
        child: Icon(Icons.add),
        ),
    );
  }

}

