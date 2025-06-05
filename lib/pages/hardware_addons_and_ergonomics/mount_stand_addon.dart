import 'package:flutter/material.dart';

class MountStandAddOnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mount/Stand Add-On')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.chair, color: Colors.deepPurple),
            title: Text('Mount/Stand Add-On', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Allows hands-free use by mounting to wheelchairs, tables, or bedside areas.'),
          ),
        ),
      ),
    );
  }
}
