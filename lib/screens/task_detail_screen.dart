
import 'package:flutter/material.dart';
import 'package:task_manager_client/models/task_model.dart';
import 'package:task_manager_client/services/task_service.dart';

class TaskDetailScreen extends StatefulWidget{
  final Task task;
  
  const TaskDetailScreen({super.key, required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();

}

class _TaskDetailScreenState extends State<TaskDetailScreen>{
  final TaskService _taskService = TaskService();
  bool _isLoading = false;

  void _toggleCompletion() async{
    setState(() => _isLoading = true);
    final success = await _taskService.updateTaskCompletion(widget.task.id, !widget.task.completed);
    setState(() {
      _isLoading = false;
      if (success) {
        Navigator.pop(context);
      }
    });
  }

 void _deleteTask() async {
    setState(() => _isLoading = true);
    final success = await _taskService.deleteTask(widget.task.id);
    if (success) {
      Navigator.pop(context); // Go back after deletion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task.title),),
      body: Padding(padding: EdgeInsets.all(16), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.description, style: TextStyle(fontSize: 16),),
            SizedBox(height: 10,),
            Text("Priority ${widget.task.priority}", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Deadline ${widget.task.deadline ?? 'No Deadline'}"),
            SizedBox(height: 20,),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),),
                        onPressed: _toggleCompletion,
                        child: Text(widget.task.completed ? "Mark Incomplete" : "Mark Complete"),
                      ),
                      ElevatedButton(
                        onPressed: _deleteTask,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red,  
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Delete Task", style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),

          ],
        ),
      ),
    );
  } 


}