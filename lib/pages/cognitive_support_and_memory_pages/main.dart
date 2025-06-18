import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CognitiveHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Daily Orientation Dashboard',
      'route': 'cognitive-options-page/dashboard',
      'icon': Icons.today
    },
    {
      'title': 'What Am I Doing?',
      'route': 'cognitive-options-page/waid',
      'icon': Icons.visibility
    },
    {
      'title': 'Digital Storybook',
      'route': 'cognitive-options-page/digital-storybook',
      'icon': Icons.menu_book
    },
    {
      'title': 'AI Check-In',
      'route': 'cognitive-options-page/ai-check-in',
      'icon': Icons.check_circle
    },
    {
      'title': 'Locked-Down Mode',
      'route': 'cognitive-options-page/locked-down-mode',
      'icon': Icons.lock
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cognitive Support App',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: GoogleFonts.poppins(fontSize: 18),
            ),
            icon: Icon(pages[index]['icon'], size: 24),
            label: Text(pages[index]['title']),
            onPressed: () {
              Navigator.pushNamed(context, pages[index]['route']);
            },
          ),
        ),
      ),
    );
  }
}
