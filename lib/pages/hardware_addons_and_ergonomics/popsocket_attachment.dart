import 'package:flutter/material.dart';

class PopsocketAttachmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popsocket Attachment')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.pan_tool_alt, color: Colors.deepPurple),
            title: Text('Popsocket Attachment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Improves device grip for users with arthritis or limited mobility.'),
          ),
        ),
      ),
    );
  }
}
