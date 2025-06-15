import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AIVideoCallSuggestionsPage extends StatelessWidget {
  final List<Map<String, String>> suggestedContacts = [
    {"name": "Mom", "phone": "+1234567890"},
    {"name": "Grandpa", "phone": "+1987654321"},
    {"name": "Sarah (Daughter)", "phone": "+1122334455"},
  ];

  void startVideoCall(String name, String phone) async {
    final Uri uri = Uri.parse("tel:$phone"); // Replace with video call URI if using a real service
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print("Could not start call to $name");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Call Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Would you like to check in with someone today?",
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: suggestedContacts.length,
                itemBuilder: (context, index) {
                  final contact = suggestedContacts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.video_call, color: Colors.deepPurple),
                      title: Text(contact["name"]!),
                      subtitle: Text("Suggested by AI"),
                      trailing: ElevatedButton(
                        onPressed: () => startVideoCall(contact["name"]!, contact["phone"]!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text("Call", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
