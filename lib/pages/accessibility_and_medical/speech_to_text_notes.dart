import 'package:flutter/material.dart';

class SpeechToTextNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Speech-to-Text Notes')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.keyboard_voice, color: Colors.deepPurple),
            title: Text('Speech-to-Text Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Use your voice to capture notes and journal entries easily.'),
          ),
        ),
      ),
    );
  }
}