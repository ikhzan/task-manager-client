
import 'package:flutter/material.dart';
import 'package:task_manager_client/models/task_model.dart';
import 'package:task_manager_client/services/task_service.dart';
import 'package:task_manager_client/widgets/task_card.dart';

class TaskList extends StatefulWidget{
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _taskService.deleteTask(task.id);
                  setState(() {
                    tasks.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: TaskCard(task: task),
              );
            },
          );
  }
}
