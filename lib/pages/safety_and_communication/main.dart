import 'package:flutter/material.dart';

class SafetyAndSupportRoutes extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'AI Video Call Suggestions', 'route': 'safety-and-communication-options-page/ai-video-call-suggestions'},
    {'title': 'Auto Emergency Calling', 'route': 'safety-and-communication-options-page/auto-emergency-calling'},
    {'title': 'Caregiver Portal', 'route': 'safety-and-communication-options-page/caregiver-portal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caregiver Portal"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
