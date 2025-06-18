import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_services.dart';
import '../../global/speaker.dart';

class AICheckInPage extends StatefulWidget {
  const AICheckInPage({super.key});

  @override
  State<AICheckInPage> createState() => _AICheckInPage();
}

class _AICheckInPage extends State<AICheckInPage> {
  List<String> questions = [];
  bool _isLoading = false;
  String _error = '';

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchQuestionsData();
  }

  void fetchQuestionsData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      final data = await ApiService.fetchAiCheckIn();
      final qList = List<String>.from(data['questions']);

      setState(() {
        questions = qList;
        _isLoading = false;
      });

      for (final question in qList) {
        await Speaker.speak(question);
        await Future.delayed(Duration(seconds: 2));
      }
    } catch (e) {
      setState(() {
        _error = "An error occurred trying to load the questions.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Check-In',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Icon(Icons.mic, color: Colors.white), // Optional: Mic icon
          SizedBox(width: 16),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(
        child: Text(
          _error,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) => Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              questions[index],
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
