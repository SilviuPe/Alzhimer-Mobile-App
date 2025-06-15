import 'package:flutter_tts/flutter_tts.dart';

class Speaker {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> _init() async {
    if (!_isInitialized) {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.5);
      await _flutterTts.setSpeechRate(1);
      await _flutterTts.awaitSpeakCompletion(true);
      _isInitialized = true;
    }
  }

  static Future<void> speak(String query) async {
    await _init();
    await _flutterTts.speak(query);
  }

  static Future<void> stop() async {
    await _flutterTts.stop();
  }
}