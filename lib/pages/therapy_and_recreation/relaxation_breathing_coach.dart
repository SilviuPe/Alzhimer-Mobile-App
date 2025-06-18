import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '../../global/speaker.dart'; // Adjust path based on your project structure

class BreathingExercisePage extends StatefulWidget {
  const BreathingExercisePage({super.key});

  @override
  State<BreathingExercisePage> createState() => _BreathingExercisePageState();
}

class _BreathingExercisePageState extends State<BreathingExercisePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _timer;
  String _instruction = "Get Ready...";
  int _totalTime = 30;
  int _elapsed = 0;

  final List<String> _cycle = ["Breathe In", "Hold", "Breathe Out"];
  int _cycleIndex = 0;
  int _phaseElapsed = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.7,
      upperBound: 1.2,
    );

    _startExercise();
  }

  void _startExercise() {
    Future.delayed(const Duration(seconds: 2), () async {
      _controller.repeat(reverse: true);
      await _setInstructionAndSpeak(_cycle[_cycleIndex]);

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        setState(() {
          _elapsed++;
          _phaseElapsed++;
        });

        if (_elapsed >= _totalTime) {
          _controller.stop();
          _timer?.cancel();
          await Speaker.speak("Well done! 🎉");
          setState(() {
            _instruction = "Well done! 🎉";
          });
          return;
        }

        if (_phaseElapsed >= 4) {
          _phaseElapsed = 0;
          _cycleIndex = (_cycleIndex + 1) % _cycle.length;
          await _setInstructionAndSpeak(_cycle[_cycleIndex]);
        }
      });
    });
  }

  Future<void> _setInstructionAndSpeak(String message) async {
    setState(() {
      _instruction = message;
    });
    await Speaker.speak(message);
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    Speaker.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("Breathing Exercise", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _controller,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.self_improvement,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              _instruction,
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Time Remaining: ${_totalTime - _elapsed}s',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.deepPurple[700]),
            ),
          ],
        ),
      ),
    );
  }
}
