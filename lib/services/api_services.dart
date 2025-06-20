import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService  {
  static const String baseUrl = 'http://145.223.101.111:5001';
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
    final response = await http.get(Uri.parse('$baseUrl/cognitive-support/ai-check'));
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


  static Future<Map<String, dynamic>> fetchMemoryFlasbacks() async {
    final response = await http.get(Uri.parse('$baseUrl/home/image-flasback'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load WAID data');
    }
  }

  static Future<Map<String, dynamic>> fetchContactsImages() async {
    final response = await http.get(Uri.parse('$baseUrl/home/contacts'));
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

  static Future<Map<String, dynamic>> fetchReminders() async {
    final response = await http.get(Uri.parse('$baseUrl/safety_and_communication/caregiver-portal'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }

  static Future<Map<String, dynamic>> fetchNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/accessibility-and-medical/speech-notes'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }

  static Future<Map<String, dynamic>> sendNotes({
    required String note,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/accessibility-and-medical/speech-notes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'note' : note
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to translate: ${response.body}');
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
