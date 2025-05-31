
import 'package:dio/dio.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/models/user_model.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  Future<User> fetchUserProfile() async {
    final token = await LocalStorage.getToken();
    final response = await _dio.get(Config.usersEndpoint, options: Options(headers: {"Authorization": "Bearer $token"}));
    
    return User.fromJson(response.data);
  }

}