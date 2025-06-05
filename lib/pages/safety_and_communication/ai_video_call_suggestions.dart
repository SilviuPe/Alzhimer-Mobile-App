import 'package:flutter/material.dart';

class AIVideoCallSuggestionsPage extends StatelessWidget {
  final List<String> suggestions = [
    'Would you like to video call Anna today?',
    'It’s been a while since you talked to John. Shall I connect you?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Video Call Suggestions'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: suggestions.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(suggestions[index], style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}