import 'package:flutter/material.dart';

class LockedDownModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Locked-Down Mode'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Settings are locked down for safety.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
