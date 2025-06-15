import 'package:flutter/material.dart';

class HearingAidCompanionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hearing Aid Companion'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.hearing, color: Colors.deepPurple),
            title: Text('Hearing Aid Companion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Connects via Bluetooth, amplifies speech, and adjusts hearing aid volume.'),
          ),
        ),
      ),
    );
  }
}
