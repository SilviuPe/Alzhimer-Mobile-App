import 'package:flutter/material.dart';
import '../../services/api_services.dart';

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
  void initState() {
    super.initState();
    fetchQuestionsData();
  }

  void fetchQuestionsData() async {
    setState(() {
      _isLoading = true;
    });
    try {

      final data = await ApiService.fetchAiCheckIn();
      setState(() {
        questions = questions = List<String>.from(data['questions']);
      });


    } catch(e) {
      setState(() {
        print(e);
        _error = "An error occured trying to load the questions.";
      });
      print(_error);
    }
    print(questions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Check-In'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(questions[index], style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
