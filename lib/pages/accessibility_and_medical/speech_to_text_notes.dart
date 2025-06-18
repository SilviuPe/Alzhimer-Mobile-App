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
      _fetchNotes();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send note.')),
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
        title: const Text("Caregiver Notes"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Speak or type your note',
                labelStyle: const TextStyle(fontSize: 16),
                border: const OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: _isListening ? Colors.red : Colors.deepPurple,
                      ),
                      onPressed: _listen,
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendNote,
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
              ),
              onSubmitted: (_) => _sendNote(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Saved Notes",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
                  : _notes.isEmpty
                  ? const Center(child: Text('No notes found.'))
                  : ListView.separated(
                itemCount: _notes.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 16),
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.sticky_note_2,
                      color: Colors.deepPurple),
                  title: Text(
                    _notes[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
