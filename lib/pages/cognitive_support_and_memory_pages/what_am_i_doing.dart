import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_services.dart';
import '../../global/speaker.dart';

class WhatAmIDoingPage extends StatefulWidget {
  const WhatAmIDoingPage({super.key});

  @override
  State<WhatAmIDoingPage> createState() => _WhatAmIDoingPageState();
}

class _WhatAmIDoingPageState extends State<WhatAmIDoingPage> {
  String _activityMessage = '';
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

    Speaker.speak(_activityMessage);

    _showContextReminder(context, _error ?? _activityMessage);
  }

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  void _showContextReminder(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Activity Reminder',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        actions: [
          TextButton(
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.deepPurple)),
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
        title: Text('What Am I Doing?', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: const [
          Icon(Icons.directions_run, color: Colors.white),
          SizedBox(width: 12),
        ],
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
                Text(
                  'Tap to Find Out',
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.lightbulb_outline, size: 28, color: Colors.white),
                  label: _isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                  )
                      : Text(
                    'What Am I Doing?',
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
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
