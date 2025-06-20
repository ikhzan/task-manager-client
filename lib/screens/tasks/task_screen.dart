import 'package:flutter/material.dart';
import 'package:task_manager_client/models/task_model.dart';
import 'package:task_manager_client/screens/tasks/add_task_screen.dart';
import 'package:task_manager_client/services/task_service.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  Future<List<Task>> _fetchTasks() async {
    return await TaskService().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: FutureBuilder<List<Task>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No tasks available."));
          }

          final tasks = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Icon(
                      task.completed ? Icons.check_circle : Icons.circle_outlined,
                      color: task.completed ? Colors.green : Colors.orange,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
