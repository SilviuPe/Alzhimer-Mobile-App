import 'package:flutter/material.dart';

class SmartGardenAppPage extends StatelessWidget {
  final List<String> plantTasks = [
    'Water your fern',
    'Check sunlight for your aloe plant',
    'Mist your orchid leaves',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Garden App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: plantTasks.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.local_florist),
          title: Text(plantTasks[index], style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}