import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LiveTranslationScreen extends StatefulWidget {
  @override
  _LiveTranslationScreenState createState() => _LiveTranslationScreenState();
}

class _LiveTranslationScreenState extends State<LiveTranslationScreen> {
  final TextEditingController _textController = TextEditingController();
  String _translatedMessage = '';
  String _sourceLang = 'en';
  String _targetLang = 'fr';
  bool _loading = false;
  String? _error;
  final List<String> _languages = ['en', 'ro', 'fr', 'es', 'de', 'it'];

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _translate() async {
    setState(() {
      _loading = true;
      _error = null;
      _translatedMessage = '';
    });

    try {
      final result = await ApiService.translateLiveMessage(
        query: _textController.text,
        src: _sourceLang,
        dest: _targetLang,
      );
      setState(() {
        _translatedMessage = result['message'] ?? 'No translation received.';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('Status: $val'),
        onError: (val) => print('Error: $val'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: _sourceLang,
          onResult: (val) {
            setState(() {
              _textController.text = val.recognizedWords;
              if (!_speech.isListening) _isListening = false;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            underline: const SizedBox(),
            items: _languages.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang.toUpperCase(),
                    style: const TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Translator'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text or use microphone',
                labelStyle: const TextStyle(fontSize: 16),
                suffixIcon: IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _listen,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildDropdown(_sourceLang, (val) {
                  if (val != null) setState(() => _sourceLang = val);
                }, 'From')),
                const SizedBox(width: 20),
                Expanded(child: _buildDropdown(_targetLang, (val) {
                  if (val != null) setState(() => _targetLang = val);
                }, 'To')),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.translate),
              label: Text(_loading ? 'Translating...' : 'Translate'),
              onPressed: _loading ? null : _translate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text('⚠️ Error: $_error',
                  style: const TextStyle(color: Colors.red, fontSize: 16)),
            if (_translatedMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple),
                ),
                child: Text(
                  _translatedMessage,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
