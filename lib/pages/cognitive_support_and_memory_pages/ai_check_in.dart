import 'package:flutter/material.dart';

class AICheckInPage extends StatelessWidget {
  final List<String> questions = [
    'How are you feeling today?',
    'Did you sleep well last night?',
    'Do you have any pain or discomfort?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Check-In'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(questions[index], style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
