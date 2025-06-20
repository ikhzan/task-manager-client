import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class AuthService {
  Future<bool> register(
    String fullName,
    String username,
    String password,
    String email,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.authEndpoint}/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          Constants.fullName: fullName,
          Constants.username: username,
          Constants.password: password,
          Constants.email: email,
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      developer.log("Error $e");
      return false;
    }

    return false;
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.authEndpoint}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          Constants.username: username,
          Constants.password: password,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final userData = jsonDecode(response.body);

        await LocalStorage.setData(Constants.userId, userData['userId']);
        await LocalStorage.setData(
          Constants.accessToken,
          userData['accessToken'],
        );

        await LocalStorage.setData(Constants.username, username);
        await LocalStorage.setData(Constants.password, password);
        if (userData.containsKey('fullName') &&
            (userData['fullName'] ?? '').toString().trim().isNotEmpty) {
          await LocalStorage.setData(Constants.fullName, userData['fullName']);
        }
        if (userData.containsKey('userTasks')) {
          final userTasks = userData['userTasks'];
          print("userTasks: $userTasks");

          // Save the summary counts
          await LocalStorage.setData(
            Constants.userTasks,
            jsonEncode({
              "completed": userTasks['completed'] ?? 0,
              "pending": userTasks['pending'] ?? 0,
            }),
          );
        }
        return true;
      }
      developer.log("Response Status: ${response.statusCode}");
      developer.log("Response Body: ${response.body}");
    } catch (e) {
      developer.log("Login failed: $e");
      return false;
    }

    return false;
  }

  Future<void> logout() async {
    await LocalStorage.clearToken();
  }
}
