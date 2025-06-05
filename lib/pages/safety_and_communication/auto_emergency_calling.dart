import 'package:flutter/material.dart';

class AutoEmergencyCallingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto-Emergency Voice Calling'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Say the panic phrase to immediately contact a caregiver or emergency services.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}