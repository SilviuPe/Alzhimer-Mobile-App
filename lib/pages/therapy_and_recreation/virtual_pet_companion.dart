import 'package:flutter/material.dart';

class VirtualPetCompanionPage extends StatefulWidget {
  @override
  _VirtualPetCompanionPageState createState() => _VirtualPetCompanionPageState();
}

class _VirtualPetCompanionPageState extends State<VirtualPetCompanionPage> {
  String message = 'Tap me!';

  void _interact() {
    setState(() {
      message = 'I love spending time with you!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Virtual Pet Companion'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: Center(
        child: GestureDetector(
          onTap: _interact,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pets, size: 100, color: Colors.purple),
              SizedBox(height: 20),
              Text(message, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
