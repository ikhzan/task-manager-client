import 'package:dio/dio.dart';
import '../config.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final response = await _dio.get("/tasks");
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<void> addTask(Map<String, dynamic> task) async {
    await _dio.post("/tasks", data: task);
  }

  Future<void> deleteTask(String id) async {
    await _dio.delete("/tasks/$id");
  }

}