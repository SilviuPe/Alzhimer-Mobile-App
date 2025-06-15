import 'package:flutter/material.dart';

class AISymptomReporterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Symptom Reporter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.medication, color: Colors.deepPurple),
            title: Text('AI Symptom Reporter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Track symptoms and trends, and automatically inform caregivers.'),
          ),
        ),
      ),
    );
  }
}
