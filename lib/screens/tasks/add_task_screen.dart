
import 'package:flutter/material.dart';
import 'package:task_manager_client/services/task_service.dart';
import 'package:task_manager_client/widgets/basic_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskService _taskService = TaskService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String priority = "medium";

  void _submitTask() async {
    if(_titleController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task title cannot be empty")));
      return;
    }
    final success = await _taskService.createTask(
      _titleController.text,
      _descriptionController.text,
      priority
    );

    if(success){
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed creating task")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text('Add New Task'),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Task Title", border: InputBorder.none), ),
            SizedBox(height: 10,),
            TextField(controller: _descriptionController, decoration: InputDecoration(labelText: "Task Description"),),
            SizedBox(height: 10,),
            DropdownButton<String>(
              value: priority,
              onChanged: (newValue) => setState(() => priority = newValue!),
              items: ["low", "medium", "high"].map((String priority) {
                return DropdownMenuItem(value: priority, child: Text(priority));
              }).toList(),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _submitTask, child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
}

