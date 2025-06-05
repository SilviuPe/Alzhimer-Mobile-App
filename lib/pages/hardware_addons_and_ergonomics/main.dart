import 'package:flutter/material.dart';

class HardwareAddonsRoutes extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'Mount/Stand Add-On', 'route': 'hardware-addons-options-page/mount-stand-addon'},
    {'title': 'Wearable Wrist Lanyard', 'route': 'hardware-addons-options-page/wrist-lanyard'},
    {'title': 'Popsocket Attachment', 'route': 'hardware-addons-options-page/popsocket_attachment'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hardware Add-ons & Ergonomics')),
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
