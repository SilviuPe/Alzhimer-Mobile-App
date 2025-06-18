import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_services.dart'; // Confirm path is correct
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
    await Speaker.speak("What number comes next in the sequence? ${sequence.join(', ')}");
  }

  Future<void> generateAudioOutputForWrongAnswer() async {
    await Speaker.speak("Not quite. Try again.");
  }

  Future<void> generateAudioOutputForCorrectAnswer() async {
    await Speaker.speak("Great job! The next number was $correctAnswer");
  }

  Future<void> _loadPuzzle() async {
    setState(() => isLoading = true);
    try {
      final data = await ApiService.fetchPuzzleCoach();
      sequence = List<int>.from(data['numbers']);
      correctAnswer = data['answer'];
      options = List<int>.from(data['options'])..shuffle();
      setState(() => isLoading = false);
      generateAudioOutputForQuestion();
    } catch (e) {
      print('Failed to load puzzle: $e');
      setState(() => isLoading = false);
    }
  }

  void _checkAnswer(int selected) {
    final isCorrect = selected == correctAnswer;
    if (isCorrect) {
      generateAudioOutputForCorrectAnswer();
    } else {
      generateAudioOutputForWrongAnswer();
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Correct! 🎉' : 'Oops! ❌',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text(
          isCorrect
              ? 'Great job! The next number was $correctAnswer.'
              : 'Not quite. Try again.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isCorrect) _loadPuzzle();
            },
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.deepPurple)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Puzzle', style: GoogleFonts.poppins()),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.deepPurple))
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What number comes next in the sequence?',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              '${sequence.join(', ')}, ?',
              style: GoogleFonts.poppins(fontSize: 28, color: Colors.deepPurple),
            ),
            const SizedBox(height: 40),
            ...options.map(
                  (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.confirmation_number, color: Colors.white, size: 24),
                  label: Text(
                    option.toString(),
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => _checkAnswer(option),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
