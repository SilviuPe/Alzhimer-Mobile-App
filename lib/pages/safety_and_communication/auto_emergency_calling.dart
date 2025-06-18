import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final List<String> panicPhrases = [
    'help me',
    'emergency',
    'call 911',
    'i need help',
    'i\'m in danger',
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
    _announceInstructions();
  }

  @override
  void dispose() {
    Speaker.stop();
    _speech.stop();
    super.dispose();
  }

  Future<void> _announceInstructions() async {
    await Speaker.speak("Please say one of the following phrases to call 911:");
    for (int i = 0; i < panicPhrases.length; i++) {
      if (i == panicPhrases.length - 1) {
        await Speaker.speak("or");
      }
      await Speaker.speak(panicPhrases[i]);
    }
  }

  Future<void> _initSpeech() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Microphone permission is required for emergency detection.')),
      );
      return;
    }

    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'done') {
          setState(() => _isListening = false);
        }
      },
      onError: (val) {
        setState(() => _isListening = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Speech recognition error: ${val.errorMsg}')),
        );
      },
    );

    if (available) {
      _startListening();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Speech recognition is not available on this device.")),
      );
    }
  }

  void _startListening() {
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
    for (final phrase in panicPhrases) {
      if (text.contains(phrase)) {
        _triggerEmergency();
        break;
      }
    }
  }

  Future<void> _triggerEmergency() async {
    const emergencyNumber = 'tel:911'; // Change to caregiver number if needed
    if (await canLaunchUrl(Uri.parse(emergencyNumber))) {
      await launchUrl(Uri.parse(emergencyNumber));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch emergency call.')),
      );
    }
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Voice Detection',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              Icons.mic,
              size: 80,
              color: _isListening ? Colors.redAccent : Colors.grey.shade600,
            ),
            const SizedBox(height: 24),
            Text(
              _isListening ? 'Listening for panic phrases...' : 'Tap Start Listening to begin',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              _lastWords.isEmpty ? 'Last heard: —' : 'Last heard: $_lastWords',
              style: GoogleFonts.poppins(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(_isListening ? Icons.stop : Icons.mic),
                label: Text(
                  _isListening ? 'Stop Listening' : 'Start Listening',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: _isListening ? _speech.stop : _startListening,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
