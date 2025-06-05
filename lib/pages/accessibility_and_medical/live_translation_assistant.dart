import 'package:flutter/material.dart';

class LiveTranslationAssistantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Translation Assistant')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.translate, color: Colors.deepPurple),
            title: Text('Live Translation Assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Real-time speech translation and simplification for better communication.'),
          ),
        ),
      ),
    );
  }
}
