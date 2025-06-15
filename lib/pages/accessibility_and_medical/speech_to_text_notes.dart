import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextNotesPage extends StatefulWidget {
  @override
  _SpeechToTextNotesPage createState() => _SpeechToTextNotesPage();
}

class _SpeechToTextNotesPage extends State<SpeechToTextNotesPage> {
  final TextEditingController _noteController = TextEditingController();
  List<String> _notes = [];
  bool _loading = true;
  String? _error;

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await ApiService.fetchNotes();
      final List<dynamic> notesList = result['notes'] ?? [];
      setState(() {
        _notes = List<String>.from(notesList);
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load notes.';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _sendNote() async {
    final note = _noteController.text.trim();
    if (note.isEmpty) return;

    try {
      await ApiService.sendNotes(note: note);
      _noteController.clear();
      _fetchNotes(); // Refresh notes list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send note.')),
      );
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _noteController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caregiver Portal"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Speak or type your note',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.mic,
                          color: _isListening ? Colors.red : null),
                      onPressed: _listen,
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendNote,
                    ),
                  ],
                ),
              ),
              onSubmitted: (_) => _sendNote(),
            ),
            SizedBox(height: 20),
            Text("Saved Notes", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            if (_loading)
              CircularProgressIndicator()
            else if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red))
            else if (_notes.isEmpty)
                Text('No notes found.')
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _notes.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.note),
                      title: Text(_notes[index]),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
