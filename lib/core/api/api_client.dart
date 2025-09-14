import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sinn_tech_assessment/core/constants/app_urls.dart';

class ApiClient {
  final http.Client _client = http.Client();

  Future<dynamic> get(String path) async {
    try {
      final response = await _client.get(Uri.parse('${AppUrls.baseUrl}$path'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle API errors gracefully
        throw Exception('Failed to load data from the API: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      throw Exception('Network error: $e');
    }
  }
}
