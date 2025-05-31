import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import '../models/task_model.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(
      Uri.parse(Config.tasksEndpoint),
        headers: {"Content-Type": "application/json"},
        
      );
      // print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map<Task>((task) => Task.fromJson(task)).toList();
      } else {
        throw Exception("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }
  


  Future<void> addTask(Task task) async {
    final token = await LocalStorage.getToken();
    await _dio.post(Config.tasksEndpoint, data: task.toJson(), options: Options(headers: {"Authorization": "Bearer $token"}));
  }

   Future<void> deleteTask(String taskId) async {
    try {
      final token = await LocalStorage.getToken();
      await _dio.delete("${Config.tasksEndpoint}/$taskId",
          options: Options(headers: {"Authorization": "Bearer $token"}));
    } catch (e) {
      print("Error deleting task: $e");
    }
  }


}