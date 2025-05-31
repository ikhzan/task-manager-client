
import 'package:dio/dio.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/models/team_model.dart';

class TeamService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Config.apiBaseUrl));

  Future<List<Team>> fetchTeams() async {
    final token = await LocalStorage.getToken();
    final response = await _dio.get(Config.teamsEndpoint, options: Options(headers: {"Authorization": "Bearer $token"}));
    
    return response.data.map<Team>((team) => Team.fromJson(team)).toList();
  }

}