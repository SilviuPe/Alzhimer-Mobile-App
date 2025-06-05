import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String weatherDescription = 'Loading...';
  String locationDescription = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    const url = 'http://10.61.20.4:5000/cognitive-support/dashboard'; // Replace with your IP and port

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final location = data['location'];
        final temp = data['temp'];

        setState(() {
          weatherDescription = '${temp.toStringAsFixed(1)}°C';
          locationDescription = location;
        });
      } else {
        setState(() {
          weatherDescription = 'Failed to fetch weather (${response.statusCode})';
          locationDescription = 'Failed to fetch weather (${response.statusCode})';
        });
      }
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
