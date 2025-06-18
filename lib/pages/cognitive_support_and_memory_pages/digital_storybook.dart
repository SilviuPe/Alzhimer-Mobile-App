import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalStorybookPage extends StatelessWidget {
  final List<Map<String, String>> stories = [
    {'image': 'assets/images/photo1.jpg', 'caption': 'At the beach with family'},
    {'image': 'assets/images/photo2.jpg', 'caption': 'Birthday celebration'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Digital Storybook',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Icon(Icons.book, color: Colors.white),
          SizedBox(width: 12),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: stories.length,
        itemBuilder: (context, index) => Card(
          elevation: 5,
          margin: EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  stories[index]['image']!,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  stories[index]['caption']!,
                  style: GoogleFonts.poppins(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
