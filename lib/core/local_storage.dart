import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/models/task_model.dart';
import 'dart:convert';

class LocalStorage {

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final tokens = prefs.getString(Constants.accessToken);
    return tokens != null;
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.accessToken);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.accessToken);
    await prefs.remove(Constants.username);
    await prefs.remove(Constants.password);
    await prefs.remove(Constants.fullName);
  }

  static Future<void> setData(String keyData, String valData) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyData, valData);
  }
  
  static Future<String?> getData(String keyData) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyData);
  }

  static String encodeTasksToJson(List<Task> tasks) {
    final List<Map<String, dynamic>> taskMaps = tasks.map((task) => task.toJson()).toList();
    return jsonEncode(taskMaps);
  }


}
