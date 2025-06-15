import 'package:flutter/material.dart';

class CognitiveHomePage extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'Daily Orientation Dashboard', 'route': 'cognitive-options-page/dashboard'},
    {'title': 'What Am I Doing?', 'route': 'cognitive-options-page/waid'},
    {'title': 'Digital Storybook', 'route': 'cognitive-options-page/digital-storybook'},
    {'title': 'AI Check-In', 'route': 'cognitive-options-page/ai-check-in'},
    {'title': 'Locked-Down Mode', 'route': 'cognitive-options-page/locked-down-mode'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cognitive Support App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(pages[index]['title']!),
    onPressed: () {
    Navigator.pushNamed(context, pages[index]['route']!);
            },
          ),
        ),
      ),
    );
  }
}
