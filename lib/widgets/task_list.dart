
import 'package:flutter/material.dart';
import 'package:task_manager_client/models/task_model.dart';
import 'package:task_manager_client/screens/task_detail_screen.dart';
import 'package:task_manager_client/services/task_service.dart';
import 'package:task_manager_client/widgets/task_card.dart';

class TaskList extends StatefulWidget{
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  _TaskListState createState() => _TaskListState();

}

class _TaskListState extends State<TaskList> {
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

  void refreshTasks() => fetchTasks(); // Refresh after deletion

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailScreen(task: tasks[index])),
          ),
          child: TaskCard(
            task: tasks[index],
            onDelete: () => refreshTasks(),
          ),
        );
      },
    );

  }
}
