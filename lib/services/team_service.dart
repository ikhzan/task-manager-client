import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/models/team_model.dart';

class TeamService {

  Future<List<Team>> fetchTeams() async {
    try {
      final token = await LocalStorage.getData(Constants.accessToken);
      final userId = await LocalStorage.getData(Constants.userId);
      if (token == null) {
        throw Exception("Authorization token is missing");
      }
      if (userId == null) {
        throw Exception("User id is missing");
      }

      final response = await http.get(
        Uri.parse(Config.teamsEndpoint),
        headers: {"Content-Type": "application/json", "Authorization": token},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map<Team>((task) => Team.fromJson(task)).toList();
      } else {
        throw Exception("Failed to load teams: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching teams: $e");
      return [];
    }
  }

  Future<List<Team>> fetchTeamsByMember() async {
    try {
      final token = await LocalStorage.getData(Constants.accessToken);
      final userId = await LocalStorage.getData(Constants.userId);
      if (token == null) {
        throw Exception("Authorization token is missing");
      }
      if (userId == null) {
        throw Exception("User id is missing");
      }

      final response = await http.get(
        Uri.parse("${Config.teamsEndpoint}/member/$userId"),
        headers: {"Content-Type": "application/json", "Authorization": token},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map<Team>((task) => Team.fromJson(task)).toList();
      } else {
        throw Exception("Failed to load teams: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching teams: $e");
      return [];
    }
  }

}