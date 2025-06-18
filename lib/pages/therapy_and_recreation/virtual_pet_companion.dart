import 'dart:math';
import 'package:flutter/material.dart';
import '../../global/speaker.dart';

class VirtualPetCompanionPage extends StatefulWidget {
  const VirtualPetCompanionPage({Key? key}) : super(key: key);

  @override
  _PetGameScreenState createState() => _PetGameScreenState();
}

class _PetGameScreenState extends State<VirtualPetCompanionPage> {
  String petName = "Fluffy";
  int hunger = 50; // 0 = full, 100 = starving
  int happiness = 50; // 0 = sad, 100 = very happy
  int energy = 50; // 0 = tired, 100 = full of energy

  bool _alertIsShowing = false; // Prevent multiple dialogs

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    generateAudioOutput();
  }

  Future<void> generateAudioOutput() async {
    await Speaker.speak("Meet your pet Fluffy, please, take care of him!");
  }

  void feed() {
    setState(() {
      hunger = max(0, hunger - 20);
    });
  }

  void play() {
    setState(() {
      if (energy >= 10) {
        happiness = min(100, happiness + 15);
        hunger = min(100, hunger + 10);
        energy = max(0, energy - 10);
      } else {
        _showAlert('$petName is too tired to play!');
      }
    });
  }

  void rest() {
    setState(() {
      energy = min(100, energy + 20);
      hunger = min(100, hunger + 5);
    });
  }

  void _showAlert(String message) {
    if (_alertIsShowing) return;

    _alertIsShowing = true;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              _alertIsShowing = false;
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void checkStatus() {
    if (hunger >= 100) {
      _showAlert('$petName is starving! 💀');
    } else if (happiness <= 0) {
      _showAlert('$petName is very sad... 💔');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Schedule checkStatus after this frame finishes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkStatus();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Pet Game'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '🐾 Meet your pet: $petName',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildStatBar('Hunger', hunger, Colors.red),
            _buildStatBar('Happiness', happiness, Colors.green),
            _buildStatBar('Energy', energy, Colors.blue),
            const SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton.icon(
                  onPressed: feed,
                  icon: const Icon(Icons.restaurant, color: Colors.white),
                  label: const Text('Feed', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: play,
                  icon: const Icon(Icons.toys, color: Colors.white),
                  label: const Text('Play', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: rest,
                  icon: const Icon(Icons.bedtime, color: Colors.white),
                  label: const Text('Rest', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value', style: const TextStyle(fontSize: 16)),
        LinearProgressIndicator(
          value: value / 100,
          minHeight: 12,
          backgroundColor: Colors.grey[300],
          color: color,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
