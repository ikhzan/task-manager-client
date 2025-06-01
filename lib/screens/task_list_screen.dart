
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
  final TaskService _taskService = TaskService();
  List<Task> tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }


  void fetchTasks() async {
    final response = await _taskService.fetchTasks();
    setState(() {
      tasks = response;
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task List"), leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: Column(
        children: [
          TaskHeader(totalTasks: tasks.length, completedTasks: tasks.where((task) => task.completed).length),
          Expanded(child: TaskList(tasks: tasks)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addTask'),
        child: Icon(Icons.add),
        ),
    );
  }

}

