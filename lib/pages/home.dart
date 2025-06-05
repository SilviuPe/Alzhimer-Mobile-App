import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'Cognitive Options', 'route': '/cognitive-options-page'},
    {'title' : 'Safety & Communication', 'route' : '/safety-and-communication-options-page'},
    {'title': 'Therapy & Recreation', 'route' : '/therapy-and-recreation-options-page'},
    {'title' : 'Accessibility & Medical', 'route' : '/accessibility-and-medical'},
    {'title' : 'Hardware Add-Ons & Ergonomics', 'route' : '/hardware-addons-options-page'},
    {'title' : 'test', 'route' : '/test'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
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
