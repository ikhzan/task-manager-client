import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> isLoggedIn() async {
    return await LocalStorage.isUserLoggedIn();
  }

  Future<Map<String, int>> _getTaskStats() async {
    final raw = await LocalStorage.getData(Constants.userTasks);
    if (raw == null || raw.isEmpty) return {"completed": 0, "pending": 0};

    final json = jsonDecode(raw);
    return {
      "completed": json["completed"] ?? 0,
      "pending": json["pending"] ?? 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FutureBuilder<Map<String, int>>(
                future: _getTaskStats(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final stats = snapshot.data!;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTaskCategory(
                            "Pending",
                            stats['pending']!,
                            Colors.orange,
                          ),
                          _buildTaskCategory(
                            "Completed",
                            stats['completed']!,
                            Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      _taskProgress(stats['completed']!, stats['pending']!),
                    ],
                  );
                },
              ),
            ),
            CardOne(),
            SizedBox(height: 20),
            Text(
              "In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(children: [
              
            ],),
          ],
        ),
      ),
    );
  }

  Widget _taskProgress(int completedTasks, int pendingTasks) {
    return Slider(
      value: completedTasks.toDouble(),
      onChanged: (_) {},
      max: (completedTasks + pendingTasks).toDouble(),
      activeColor: Colors.blue,
    );
  }

  Widget _buildTaskCategory(String title, int count, Color color) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        CircleAvatar(
          backgroundColor: color,
          child: Text("$count", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurpleAccent,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your today's task almost here",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                  child: Text('View Task'),
                ),
              ],
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
