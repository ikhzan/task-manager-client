
import 'package:flutter/material.dart';

class TaskDashboard extends StatelessWidget{
   final int pendingTasks;
  final int completedTasks;

  const TaskDashboard({super.key, required this.pendingTasks, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTaskCategory("Pending", pendingTasks, Colors.orange),
            _buildTaskCategory("Completed", completedTasks, Colors.green),
          ],
        ),
        Slider(
          value: completedTasks.toDouble(),
          max: (completedTasks + pendingTasks).toDouble(),
          activeColor: Colors.blue,
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _buildTaskCategory(String title, int count, Color color) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        CircleAvatar(backgroundColor: color, child: Text("$count")),
      ],
    );
  }

}