import 'package:flutter/material.dart';

class TherapyAndRecreationRoutes extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'Puzzle Coach', 'route': 'therapy-and-recreation-options-page/cognitive-puzzle-coach'},
    {'title': 'Drawing Guide', 'route': 'therapy-and-recreation-options-page/guided-drawing-app'},
    {'title': 'Breathing Coach', 'route': 'therapy-and-recreation-options-page/relaxation-breathing-coach'},
    {'title': 'Smart Garden App', 'route': 'therapy-and-recreation-options-page/smart-garden-app'},
    {'title': 'Virtual Pet Companion', 'route': 'therapy-and-recreation-options-page/virtual-pet-companion'},
  ];

  // 'therapy-and-recreation-options-page/smart-garden-app' : (context) => SmartGardenAppPage(),
  // 'therapy-and-recreation-options-page/virtual-pet-companion': (context) => VirtualPetCompanionPage()


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Therapy & Recreation')),
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
