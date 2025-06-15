
import 'package:flutter/material.dart';
import 'package:task_manager_client/services/task_service.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function onDelete;
  final TaskService _taskService = TaskService();

  TaskCard({super.key, required this.task, required this.onDelete});

  void _deleteTask() async{
    await _taskService.deleteTask(task.id);
    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        leading: Icon(task.completed ? Icons.check_circle: Icons.radio_button_unchecked_outlined),
        trailing: IconButton(onPressed: _deleteTask, icon: Icon(Icons.delete, color: Colors.red,)),
      ),
    );
  }

}