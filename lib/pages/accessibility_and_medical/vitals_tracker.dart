import 'package:flutter/material.dart';

class VitalsTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vitals Tracker'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.monitor_heart, color: Colors.deepPurple),
            title: Text('Vitals Tracker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Syncs with BP cuff, pulse ox, and more to monitor your health.'),
          ),
        ),
      ),
    );
  }
}