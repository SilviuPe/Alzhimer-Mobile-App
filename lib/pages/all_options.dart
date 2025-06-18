import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllOptions extends StatelessWidget {
  final List<Map<String, dynamic>> pages = [
    {'title': 'Home', 'route': '/home', 'icon': Icons.home},
    {'title': 'Cognitive Options', 'route': '/cognitive-options-page', 'icon': Icons.psychology},
    {'title': 'Safety & Communication', 'route': '/safety-and-communication-options-page', 'icon': Icons.security},
    {'title': 'Therapy & Recreation', 'route': '/therapy-and-recreation-options-page', 'icon': Icons.sports_handball},
    {'title': 'Accessibility & Medical', 'route': '/accessibility-and-medical', 'icon': Icons.medical_services},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options', style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton.icon(
            icon: Icon(pages[index]['icon'], size: 24),
            label: Text(
              pages[index]['title'],
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
