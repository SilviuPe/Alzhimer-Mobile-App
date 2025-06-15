import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global/speaker.dart';

class AIVideoCallSuggestionsPage extends StatefulWidget {
  const AIVideoCallSuggestionsPage({super.key});

  @override
  State<AIVideoCallSuggestionsPage> createState() => _AIVideoCallSuggestionsPageState();
}

class _AIVideoCallSuggestionsPageState extends State<AIVideoCallSuggestionsPage> {
  final List<Map<String, String>> suggestedContacts = [
    {"name": "Mom", "phone": "+1234567890"},
    {"name": "Grandpa", "phone": "+1987654321"},
    {"name": "Sarah (Daughter)", "phone": "+1122334455"},
  ];

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Wait until the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateAudioOutput();
    });
  }

  Future<void> generateAudioOutput() async {
    await Speaker.speak("You can call");
    for (int i = 0; i < suggestedContacts.length; i++) {

      final contact = suggestedContacts[i];
      if (i == suggestedContacts.length - 1) {
        await Speaker.speak('or');
      }
      await Speaker.speak(contact['name'] ?? '');
    }
  }

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
      appBar: AppBar(
        title: const Text("Video Call Suggestions"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Would you like to check in with someone today?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: suggestedContacts.length,
                itemBuilder: (context, index) {
                  final contact = suggestedContacts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.video_call, color: Colors.deepPurple),
                      title: Text(contact["name"]!),
                      subtitle: const Text("Suggested by AI"),
                      trailing: ElevatedButton(
                        onPressed: () => startVideoCall(contact["name"]!, contact["phone"]!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text("Call", style: TextStyle(color: Colors.white)),
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
