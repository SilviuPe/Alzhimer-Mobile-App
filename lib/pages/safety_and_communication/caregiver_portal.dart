import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_services.dart';
import '../../global/speaker.dart';

class CaregiverPortalPage extends StatefulWidget {
  @override
  _CaregiverPortalPage createState() => _CaregiverPortalPage();
}

class _CaregiverPortalPage extends State<CaregiverPortalPage> {
  bool locationTrackingEnabled = true;
  bool medicationRemindersOn = true;
  bool emergencyAlertsOn = false;
  bool _isLoadingReminders = true;
  String _error = '';

  List<String> reminders = [];

  List<String> alerts = [
    "No activity detected since 10:30 AM",
    "Missed medication alert at 8:00 AM",
  ];

  @override
  void initState() {
    super.initState();
    fetchReminders();
  }

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  Future<void> generateAudioOutput() async {
    await Speaker.speak("You have the following reminders:");
    for (final reminder in reminders) {
      await Speaker.speak(reminder);
    }
    await Speaker.speak("Please, make sure you do not forget about them.");
  }

  void fetchReminders() async {
    setState(() {
      _isLoadingReminders = true;
    });
    try {
      final data = await ApiService.fetchReminders();
      setState(() {
        reminders = [
          if (data['previous'] != null) 'Previous: ${data['previous']}',
          if (data['current'] != null) 'Current: ${data['current']}',
          if (data['next'] != null) 'Next: ${data['next']}',
        ];
        _isLoadingReminders = false;
        _error = '';
      });
      generateAudioOutput();
    } catch (e) {
      setState(() {
        _error = "An error occurred trying to load reminders.";
        _isLoadingReminders = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Caregiver Portal",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Remote Controls",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: Text("Enable Location Tracking", style: GoogleFonts.poppins(fontSize: 18)),
              secondary: const Icon(Icons.location_on_outlined, color: Colors.deepPurple),
              value: locationTrackingEnabled,
              onChanged: (val) => setState(() => locationTrackingEnabled = val),
            ),
            SwitchListTile(
              title: Text("Medication Reminders", style: GoogleFonts.poppins(fontSize: 18)),
              secondary: const Icon(Icons.medical_services_outlined, color: Colors.deepPurple),
              value: medicationRemindersOn,
              onChanged: (val) => setState(() => medicationRemindersOn = val),
            ),
            SwitchListTile(
              title: Text("Emergency Alerts", style: GoogleFonts.poppins(fontSize: 18)),
              secondary: const Icon(Icons.warning_amber_outlined, color: Colors.redAccent),
              value: emergencyAlertsOn,
              onChanged: (val) => setState(() => emergencyAlertsOn = val),
            ),
            const Divider(height: 40, thickness: 1.2),
            Text(
              "Reminders",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 8),
            if (_isLoadingReminders)
              Center(child: CircularProgressIndicator(color: Colors.deepPurple))
            else if (_error.isNotEmpty)
              Text(_error, style: GoogleFonts.poppins(color: Colors.red, fontSize: 16))
            else if (reminders.isEmpty)
                Text("No reminders at this time.", style: GoogleFonts.poppins(fontSize: 16))
              else
                ...reminders.map(
                      (reminder) => ListTile(
                    leading: const Icon(Icons.alarm, color: Colors.deepPurple),
                    title: Text(reminder, style: GoogleFonts.poppins(fontSize: 18)),
                  ),
                ),
            const Divider(height: 40, thickness: 1.2),
            Text(
              "Alerts",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 8),
            ...alerts.map(
                  (alert) => ListTile(
                leading: const Icon(Icons.warning, color: Colors.redAccent),
                title: Text(alert, style: GoogleFonts.poppins(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
