import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import '../models/task_model.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  Future<bool> updateTaskCompletion(String taskId, bool completed) async {
    final token = await LocalStorage.getAuthToken();
    final response = await http.patch(
      Uri.parse("${Config.tasksEndpoint}/$taskId"),
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      body: jsonEncode({"completed": completed}),
    );

    return response.statusCode == 200;
  }

  Future<List<Task>> fetchTasks() async {
    try {
      final token = await LocalStorage.getToken();
      if (token == null) {
        throw Exception("Authorization token is missing");
      }
      final response = await http.get(
      Uri.parse(Config.tasksEndpoint),
        headers: {"Content-Type": "application/json", "Authorization": token},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.isEmpty) {
          print("No tasks found"); // Debug log
        }

        return jsonData.map<Task>((task) => Task.fromJson(task)).toList();
      } else {
        throw Exception("Failed to load tasks: ${response.statusCode}");
      }

    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }

  Future<bool> createTask(String title, String description, String priority) async {
    final token = await LocalStorage.getAuthToken();
    final userId = await LocalStorage.getUserId(); // Retrieve stored user ID

    if (userId == null) {
      print("Error: User ID is missing.");
      return false;
    }

    final response = await http.post(
      Uri.parse(Config.tasksEndpoint),
      headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      body: jsonEncode({
        "title": title, 
        "description": description, 
        "priority": priority,
        "user": userId
      }),
    );

    return response.statusCode == 201;
  }
  

  Future<void> addTask(Task task) async {
    final token = await LocalStorage.getToken();
    await _dio.post(Config.tasksEndpoint, data: task.toJson(), options: Options(headers: {"Authorization": "Bearer $token"}));
  }

   Future<bool> deleteTask(String taskId) async {
    try {
      final token = await LocalStorage.getToken();
      final response = await http.delete(
          Uri.parse("${Config.tasksEndpoint}/$taskId"),
          headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        return true;
      }

     

      // await _dio.delete("${Config.tasksEndpoint}/$taskId",
      //     options: Options(headers: {"Authorization": "Bearer $token"}));
    } catch (e) {
      print("Error deleting task: $e");
    }

    return false;
  }


}