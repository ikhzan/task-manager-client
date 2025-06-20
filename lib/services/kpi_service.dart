import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/config.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/models/kpi_model.dart';

class KpiService {

  Future<List<Kpi>> fetchkpis() async {
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
        Uri.parse(Config.kpiEndpoint),
        headers: {"Content-Type": "application/json", "Authorization": token},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print("Kpi-data $jsonData");

        return jsonData.map<Kpi>((kpi) => Kpi.fromJson(kpi)).toList();
      } else {
        throw Exception("Failed to load kpi: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching kpi: $e");
      return [];
    }
  }
}