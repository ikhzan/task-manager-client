import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class ApiHelper{
  

  static Map<String,String> _getHeaders(String? token){
    return {
      "Content-type": "application/json",
      if(token != null) "Authorization": "Bearer $token"
    };
  }

  static Future<dynamic> getRequest(String endpoint, {String? token}) async{
    try{
      final response = await http.get(Uri.parse(Config.apiBaseUrl + endpoint), headers: _getHeaders(token));
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("Error: ${response.statusCode}");
      }
    }catch(e){
      print("Api Error: $e");
      return null;
    }
  }

  static Future<dynamic> postRequest(String endpoint, Map<String,dynamic> data, {String? token}) async{
    try{
      final response = await http.post(
        Uri.parse(Config.apiBaseUrl + endpoint), 
        headers: _getHeaders(token),
        body: jsonEncode(data)
      );
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception("Error: ${response.statusCode}");
      }
    }catch(e){
      print("Api Error: $e");
      return null;
    }
  }
}