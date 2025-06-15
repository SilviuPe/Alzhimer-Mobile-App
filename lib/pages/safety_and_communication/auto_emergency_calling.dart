import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../global/speaker.dart';

class AutoEmergencyCallingPage extends StatefulWidget {
  @override
  _AutoEmergencyCallingPage createState() => _AutoEmergencyCallingPage();
}

class _AutoEmergencyCallingPage extends State<AutoEmergencyCallingPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _lastWords = '';
  final List<String> panicPhrases = ['help me', 'emergency', 'call 911', 'i need help', 'i\'m in danger'];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
    generateOutput();
  }

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  Future<void> generateOutput() async {
    await Speaker.speak("Please say the following phrases in order to call 911:");

    for (int i =0; i<panicPhrases.length; i++) {
      if (i == panicPhrases.length-1) {
        await Speaker.speak('or');
      }
      await Speaker.speak(panicPhrases[i]);

    }
  }

  Future<void> _initSpeech() async {
    await Permission.microphone.request();
    bool available = await _speech.initialize();
    if (available) {
      _startListening();
    } else {
      print("Speech not available");
    }
  }

  void _startListening() async {
    if (!_isListening) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _lastWords = result.recognizedWords.toLowerCase();
          });
          _checkForPanicPhrase(_lastWords);
        },
        listenMode: stt.ListenMode.confirmation,
        partialResults: true,
      );
      setState(() => _isListening = true);
    }
  }

  void _checkForPanicPhrase(String text) {
    for (var phrase in panicPhrases) {
      if (text.contains(phrase)) {
        _triggerEmergency();
        break;
      }
    }
  }

  void _triggerEmergency() async {
    const caregiverNumber = 'tel:911'; // Or caregiver's number
    if (await canLaunchUrl(Uri.parse(caregiverNumber))) {
      await launchUrl(Uri.parse(caregiverNumber));
    } else {
      print('Could not launch emergency call');
    }
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Voice Detection'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.mic, size: 64, color: _isListening ? Colors.red : Colors.grey),
            SizedBox(height: 20),
            Text('Listening for panic phrases...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Last heard: $_lastWords', style: TextStyle(fontStyle: FontStyle.italic)),
            Spacer(),
            ElevatedButton(
              onPressed: _isListening ? _speech.stop : _startListening,
              child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
            ),
          ],
        ),
      ),
    );
  }
}
