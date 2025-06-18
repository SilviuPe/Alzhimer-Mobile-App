import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafetyAndSupportRoutes extends StatelessWidget {
  final List<Map<String, dynamic>> pages = [
    {
      'title': 'AI Video Call Suggestions',
      'route': 'safety-and-communication-options-page/ai-video-call-suggestions',
      'icon': Icons.video_call
    },
    {
      'title': 'Auto Emergency Calling',
      'route': 'safety-and-communication-options-page/auto-emergency-calling',
      'icon': Icons.local_hospital
    },
    {
      'title': 'Caregiver Portal',
      'route': 'safety-and-communication-options-page/caregiver-portal',
      'icon': Icons.family_restroom
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Caregiver Portal",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton.icon(
            icon: Icon(pages[index]['icon'], size: 28, color: Colors.white),
            label: Text(
              pages[index]['title'],
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, pages[index]['route']);
            },
          ),
        ),
      ),
    );
  }
}
