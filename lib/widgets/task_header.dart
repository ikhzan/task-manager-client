import 'package:flutter/material.dart';

class TaskHeader extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  const TaskHeader({super.key, required this.totalTasks, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tasks Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: $totalTasks"),
                Text("Completed: $completedTasks"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}