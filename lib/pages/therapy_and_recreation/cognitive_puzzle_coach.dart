import 'package:flutter/material.dart';
import '../../services/api_services.dart'; // Make sure this path matches your project structure
import '../../global/speaker.dart';

void main() => runApp(const MaterialApp(home: NumberSequencePuzzle()));

class NumberSequencePuzzle extends StatefulWidget {
  const NumberSequencePuzzle({super.key});

  @override
  State<NumberSequencePuzzle> createState() => _NumberSequencePuzzleState();
}

class _NumberSequencePuzzleState extends State<NumberSequencePuzzle> {
  List<int> sequence = [];
  int correctAnswer = 0;
  List<int> options = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPuzzle();
  }

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  Future<void> generateAudioOutputForQuestion() async {
    await Speaker.speak("What number comes next in the sequence? ${sequence}");
  }

  Future<void> generateAudioOutputForWrongAnswer() async {
    await Speaker.speak("Not quite. Try again.");
  }

  Future<void> generateAudioOutputForCorrectAnswer() async {
    await Speaker.speak("Great job! The next number was ${correctAnswer}");
  }

  Future<void> _loadPuzzle() async {
    setState(() => isLoading = true);
    try {
      final data = await ApiService.fetchPuzzleCoach();
      sequence = List<int>.from(data['numbers']);
      correctAnswer = data['answer'];

      // Generate options with the correct answer and two distractors
      options =  List<int>.from(data['options'])..shuffle();

      setState(() => isLoading = false);

      generateAudioOutputForQuestion();

    } catch (e) {
      print('Failed to load puzzle: $e');
      setState(() => isLoading = false);
    }
  }

  void _checkAnswer(int selected) {
    final bool isCorrect = selected == correctAnswer;
    if (isCorrect) {
      generateAudioOutputForCorrectAnswer();
    }
    else {
      generateAudioOutputForWrongAnswer();
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Oops!'),
        content: Text(
          isCorrect
              ? 'Great job! The next number was $correctAnswer.'
              : 'Not quite. Try again.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isCorrect) _loadPuzzle(); // Load new puzzle on correct answer
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Puzzle'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What number comes next in the sequence?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              '${sequence.join(', ')}, ?',
              style: const TextStyle(fontSize: 26, color: Colors.deepPurple),
            ),
            const SizedBox(height: 40),
            ...options.map(
                  (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => _checkAnswer(option),
                  child: Text(
                    option.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
