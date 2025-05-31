// import 'package:dio/dio.dart';
// import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthService {

  Future<bool> login(String username, String password) async {
    try{
    final response = await http.post(
      Uri.parse("${Config.authEndpoint}login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

      if (response.statusCode == 201) {
        await LocalStorage.setUsername(username);
        await LocalStorage.setPassword(password);
        return true;
      }

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }catch(e){
      print("Login failed: $e");
      return false;
    }
    

    return false;
  }

  Future<void> logout() async {
    await LocalStorage.clearToken();
  }

}


