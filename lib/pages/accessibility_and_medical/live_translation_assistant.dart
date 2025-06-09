import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_services.dart';

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

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: _languages.map((lang) {
        return DropdownMenuItem(
          value: lang,
          child: Text(lang.toUpperCase()),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Translator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('From'),
                    _buildDropdown(_sourceLang, (val) {
                      if (val != null) setState(() => _sourceLang = val);
                    }),
                  ],
                ),
                Column(
                  children: [
                    Text('To'),
                    _buildDropdown(_targetLang, (val) {
                      if (val != null) setState(() => _targetLang = val);
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _translate,
              child: Text(_loading ? 'Translating...' : 'Translate'),
            ),
            SizedBox(height: 16),
            if (_error != null)
              Text('Error: $_error', style: TextStyle(color: Colors.red)),
            if (_translatedMessage.isNotEmpty)
              Text(
                'Translation: $_translatedMessage',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
