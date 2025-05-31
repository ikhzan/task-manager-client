import 'package:flutter/material.dart';
import '../core/network/api_service.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
   final ApiService _apiService = ApiService();
  List<Task> tasks = [];

  Future<void> fetchTasks() async {
    final response = await _apiService.fetchTasks();
    tasks = response.map((task) => Task.fromJson(task)).toList();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _apiService.addTask(task.toJson());
    fetchTasks();
  }

}