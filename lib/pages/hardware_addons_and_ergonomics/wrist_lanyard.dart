import 'package:flutter/material.dart';

class WristLanyardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wearable Wrist Lanyard')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.watch, color: Colors.deepPurple),
            title: Text('Wearable Wrist Lanyard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Prevents accidental drops and helps users keep track of their device.'),
          ),
        ),
      ),
    );
  }
}
