import 'package:flutter/material.dart';

class CaregiverPortalPage extends StatelessWidget {
  final List<String> features = [
    'Remotely update user settings',
    'Send alerts or reminders to the app',
    'Monitor health and check-in responses',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Caregiver Portal'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: features.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.settings_remote),
          title: Text(features[index], style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}