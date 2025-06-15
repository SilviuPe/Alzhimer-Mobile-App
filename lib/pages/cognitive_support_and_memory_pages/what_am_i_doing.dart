import 'package:flutter/material.dart';
import '../../services/api_services.dart'; // Adjust the path to your ApiService file

class WhatAmIDoingPage extends StatefulWidget {
  const WhatAmIDoingPage({super.key});

  @override
  State<WhatAmIDoingPage> createState() => _WhatAmIDoingPageState();
}

class _WhatAmIDoingPageState extends State<WhatAmIDoingPage> {
  String? _activityMessage;
  bool _isLoading = false;
  String? _error;

  void _fetchActivity() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await ApiService.fetchWhatAmIDoing();
      setState(() {
        _activityMessage = data['message'] ?? 'No activity detected.';
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load activity.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    if (_activityMessage != null) {
      _showContextReminder(context, _activityMessage!);
    } else if (_error != null) {
      _showContextReminder(context, _error!);
    }
  }

  void _showContextReminder(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Activity Reminder',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            child: const Text('OK', style: TextStyle(color: Colors.deepPurple)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('What Am I Doing?'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 8,
          color: Colors.white,
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tap to Find Out',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.lightbulb_outline, size: 28, color:Colors.white),
                  label: _isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    'What Am I Doing?',
                    style: TextStyle(fontSize: 20, color:Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _isLoading ? null : _fetchActivity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
