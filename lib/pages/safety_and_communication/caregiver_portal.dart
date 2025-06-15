import 'package:flutter/material.dart';
import '../../services/api_services.dart';

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

  void fetchReminders() async {
    setState(() {
      _isLoadingReminders = true;
    });
    try {

      final data = await ApiService.fetchReminders();
      setState(() {
        reminders = [
          if (data['previous'] != null) 'Previous ${data['previous']}',
          if (data['current'] != null) 'Current ${data['current']}',
          if (data['next'] != null) 'Next ${data['next']}',
        ];
      });


    } catch(e) {
      setState(() {
        _error = "An error occured trying to load the questions.";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caregiver Portal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Remote Controls",
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 12),
            SwitchListTile(
              title: Text("Enable Location Tracking"),
              value: locationTrackingEnabled,
              onChanged: (val) {
                setState(() => locationTrackingEnabled = val);
              },
            ),
            SwitchListTile(
              title: Text("Medication Reminders"),
              value: medicationRemindersOn,
              onChanged: (val) {
                setState(() => medicationRemindersOn = val);
              },
            ),
            SwitchListTile(
              title: Text("Emergency Alerts"),
              value: emergencyAlertsOn,
              onChanged: (val) {
                setState(() => emergencyAlertsOn = val);
              },
            ),
            Divider(height: 32),
            Text("Reminders",
                style: Theme.of(context).textTheme.titleLarge),
            ...reminders.map((reminder) => ListTile(
              leading: Icon(Icons.alarm),
              title: Text(reminder),
            )),
            Divider(height: 32),
            Text("Alerts", style: Theme.of(context).textTheme.titleLarge),
            ...alerts.map((alert) => ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text(alert),
            )),
          ],
        ),
      ),
    );
  }
}
