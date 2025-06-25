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
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task title cannot be empty")));
      return;
    }
    final success = await _taskService.createTask(
      _titleController.text,
      _descriptionController.text,
      priority,
    );

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed creating task")));
    }
  }

  Widget _titleField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.title),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _descriptionField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.title),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Add New Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),
        color: Colors.black.withAlpha(40),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _titleField(context),
                  SizedBox(height: 10),
                  _descriptionField(context),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            Checkbox(
                              activeColor: Colors.red,
                              value: priority == "high",
                              onChanged: (bool? value) {
                                setState(() {
                                  priority = value == true ? "high" : "";
                                });
                              },
                            ),
                            Text('High'),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Checkbox(
                              activeColor: Colors.orange,
                              value: priority == "medium",
                              onChanged: (bool? value) {
                                setState(() {
                                  priority = value == true ? "medium" : "";
                                });
                              },
                            ),
                            Text('Medium'),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Checkbox(
                              activeColor: Colors.green,
                              value: priority == "low",
                              onChanged: (bool? value) {
                                setState(() {
                                  priority = value == true ? "low" : "";
                                });
                              },
                            ),
                            Text('Low'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        onPressed: _submitTask,
                        child: Text("Add Task"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
