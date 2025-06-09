import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService  {
  static const String baseUrl = 'http://192.168.0.105:5000';
  // Dashboard: Weather & Location
  static Future<Map<String, dynamic>> fetchDashboard() async {
    final response = await http.get(Uri.parse('$baseUrl/cognitive-support/dashboard'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }

  // AI Check-In
  static Future<Map<String, dynamic>> fetchAiCheckIn() async {
    final response = await http.get(Uri.parse('$baseUrl/cognitive-support/ai-check-in'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load AI Check-In data');
    }
  }

  // Digital Storybook
  static Future<List<dynamic>> fetchDigitalStorybook() async {
    final response = await http.get(Uri.parse('$baseUrl/cognitive-support/digital-storybook'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Expecting a list of stories
    } else {
      throw Exception('Failed to load storybook');
    }
  }

  // Locked Down Mode
  static Future<Map<String, dynamic>> fetchLockedDownMode() async {
    final response = await http.get(Uri.parse('$baseUrl/cognitive-support/locked-down-mode'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load locked down mode state');
    }
  }

  // What Am I Doing (WAID)
  static Future<Map<String, dynamic>> fetchWhatAmIDoing() async {
    final response = await http.get(Uri.parse('$baseUrl/cognitive-support/what-am-i-doing'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load WAID data');
    }
  }


  static Future<Map<String, dynamic>> fetchPuzzleCoach() async {
    final response = await http.get(Uri.parse('$baseUrl/therapy-and-recreation/puzzle-coach'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }


  static Future<Map<String, dynamic>> translateLiveMessage({
    required String query,
    required String src,
    required String dest,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/accessibility-and-medical/live-translation-assistant'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'query': query,
        'src': src,
        'dest': dest,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to translate: ${response.body}');
    }
  }
}
