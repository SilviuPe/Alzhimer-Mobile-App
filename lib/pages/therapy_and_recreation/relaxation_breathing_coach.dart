import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MaterialApp(home: BreathingExercisePage()));

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
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _instruction = _cycle[_cycleIndex];
      });
      _controller.repeat(reverse: true);

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsed++;
          _phaseElapsed++;

          if (_elapsed >= _totalTime) {
            _instruction = "Well done! 🎉";
            _controller.stop();
            _timer?.cancel();
            return;
          }

          if (_phaseElapsed >= 4) {
            _phaseElapsed = 0;
            _cycleIndex = (_cycleIndex + 1) % _cycle.length;
            _instruction = _cycle[_cycleIndex];
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("Breathing Exercise"),
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
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _instruction,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Time Remaining: ${_totalTime - _elapsed}s',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
