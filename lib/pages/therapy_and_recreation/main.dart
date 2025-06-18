import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapyAndRecreationRoutes extends StatelessWidget {
  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Puzzle Coach',
      'route': 'therapy-and-recreation-options-page/cognitive-puzzle-coach',
      'icon': Icons.extension, // puzzle piece icon
    },
    {
      'title': 'Drawing Guide',
      'route': 'therapy-and-recreation-options-page/guided-drawing-app',
      'icon': Icons.brush,
    },
    {
      'title': 'Breathing Coach',
      'route': 'therapy-and-recreation-options-page/relaxation-breathing-coach',
      'icon': Icons.self_improvement,
    },
    {
      'title': 'Smart Garden App',
      'route': 'therapy-and-recreation-options-page/smart-garden-app',
      'icon': Icons.local_florist,
    },
    {
      'title': 'Virtual Pet Companion',
      'route': 'therapy-and-recreation-options-page/virtual-pet-companion',
      'icon': Icons.pets,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Therapy & Recreation',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
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
