import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';
import '../core/network/api_service.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
   final ApiService _apiService = ApiService();
    List<Task> _tasks = [];

  List<Task> get tasks => _tasks;


   Future<void> loadTasks() async {
    final raw = await LocalStorage.getData(Constants.userTasks);
    if (raw != null && raw.isNotEmpty) {
      final List decoded = jsonDecode(raw);
      _tasks = decoded.map((e) => Task.fromJson(e)).toList();
      notifyListeners();
    }
  }


  Future<void> addTask(Task task) async {
    await _apiService.addTask(task.toJson());
    loadTasks();
  }

}