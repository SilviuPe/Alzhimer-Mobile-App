import 'package:flutter/material.dart';

class AccessibilityAndMedicalRoutes extends StatelessWidget {
  final List<Map<String, dynamic>> pages = [
    {
      'title': 'AI Symptom Reporter',
      'route': 'accessibility-and-medical/ai-symptom-reporter',
      'icon': Icons.medical_services,
    },
    {
      'title': 'Hearing AID Companion',
      'route': 'accessibility-and-medical/hearing-aid-companion',
      'icon': Icons.hearing,
    },
    {
      'title': 'Live Translation Assistant',
      'route': 'accessibility-and-medical/live-translation-assistant',
      'icon': Icons.translate,
    },
    {
      'title': 'Speech To Text Notes',
      'route': 'accessibility-and-medical/speech-to-text-notes',
      'icon': Icons.mic,
    },
    {
      'title': 'Vitals Tracker',
      'route': 'accessibility-and-medical/vitals-tracker',
      'icon': Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accessibility & Medical',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton.icon(
              icon: Icon(page['icon'], size: 28),
              label: Text(
                page['title'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, page['route']),
            ),
          );
        },
      ),
    );
  }
}
