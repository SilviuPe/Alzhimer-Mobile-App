import 'package:flutter/material.dart';

class DigitalStorybookPage extends StatelessWidget {
  final List<Map<String, String>> stories = [
    {'image': 'assets/images/photo1.jpg', 'caption': 'At the beach with family'},
    {'image': 'assets/images/photo2.jpg', 'caption': 'Birthday celebration'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Digital Storybook'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: stories.length,
        itemBuilder: (context, index) => Card(
          child: Column(
            children: [
              Image.asset(stories[index]['image']!),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(stories[index]['caption']!, style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}