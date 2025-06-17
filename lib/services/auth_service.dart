import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<bool> register(String username, String password, String email) async {
    try{
      final response = await http.post(
        Uri.parse("${Config.authEndpoint}/register"),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({"username":username, "password":password, "email":email})
      );
      if(response.statusCode == 201 || response.statusCode == 200){
        return true;
      }
    }catch(e){
      print("Error $e");
      return false;
    }

    return false;
  }

  Future<bool> login(String username, String password) async {
    try{
      final response = await http.post(
        Uri.parse("${Config.authEndpoint}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 201) {
        final userData = jsonDecode(response.body);
  
        await LocalStorage.setUserId(userData['userId']);
        await LocalStorage.setToken(userData['accessToken']);

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


