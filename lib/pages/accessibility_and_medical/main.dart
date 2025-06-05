import 'package:flutter/material.dart';

class AccessibilityAndMedicalRoutes extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'AI Symptom Reporter', 'route': 'accessibility-and-medical/ai-symptom-reporter'},
    {'title': 'Hearing AID Companion', 'route': 'accessibility-and-medical/hearing-aid-companion'},
    {'title': 'Live Translation Assistant', 'route': 'accessibility-and-medical/live-translation-assistant'},
    {'title': 'Speech To Text Notes', 'route': 'accessibility-and-medical/speech-to-text-notes'},
    {'title': 'Vitals Tracker', 'route': 'accessibility-and-medical/vitals-tracker'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accessibility & Medical')),
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
