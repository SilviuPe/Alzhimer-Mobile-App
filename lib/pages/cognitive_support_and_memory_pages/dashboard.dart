import 'package:flutter/material.dart';
import '../../services/api_services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String weatherDescription = 'Loading...';
  String locationDescription = 'Loading...';
  final FlutterTts flutterTts = FlutterTts();

  void _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.5);
    await flutterTts.setSpeechRate(1.5); // Slower for clarity
    await flutterTts.speak(
        "Hello! Today is a beautiful day. You're in $locationDescription and the weather is $weatherDescription. How are you feeling?"
    );
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
    flutterTts.awaitSpeakCompletion(true);
    _speak();
  }
  Future<void> fetchWeather() async {

    try {
        final responseData = await ApiService.fetchDashboard();
        final location = responseData['location'];
        final temp = responseData['temp'];

        setState(() {
          weatherDescription = '${temp.toStringAsFixed(1)}°C';
          locationDescription = location;
        });
    } catch (e) {
      setState(() {
        weatherDescription = 'Error connecting to server';
        locationDescription = 'Error connecting to server';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Daily Orientation'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(
              icon: Icons.calendar_today,
              title: 'Date',
              content: '${now.day}/${now.month}/${now.year}',
            ),
            _infoCard(
              icon: Icons.access_time,
              title: 'Time',
              content: '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
            ),
            _infoCard(
              icon: Icons.location_on,
              title: 'Location',
              content: locationDescription,
            ),
            _infoCard(
              icon: Icons.wb_sunny,
              title: 'Weather',
              content: weatherDescription,
            ),
            _infoCard(
              icon: Icons.repeat,
              title: 'Today\'s Routine',
              content: 'Coming soon...',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple, size: 30),
        title: Text(title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text(content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            )),
      ),
    );
  }
}
