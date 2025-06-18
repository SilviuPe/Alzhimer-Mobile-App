import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../global/speaker.dart';

class AIVideoCallSuggestionsPage extends StatefulWidget {
  const AIVideoCallSuggestionsPage({super.key});

  @override
  State<AIVideoCallSuggestionsPage> createState() =>
      _AIVideoCallSuggestionsPageState();
}

class _AIVideoCallSuggestionsPageState
    extends State<AIVideoCallSuggestionsPage> {
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
    // Speak suggestions after first frame is rendered
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
    // This uses phone call URI as placeholder for video call
    final Uri uri = Uri.parse("tel:$phone");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not start call to $name")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video Call Suggestions",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Would you like to check in with someone today?",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: suggestedContacts.length,
                itemBuilder: (context, index) {
                  final contact = suggestedContacts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.video_call,
                          color: Colors.deepPurple, size: 32),
                      title: Text(contact["name"]!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                      subtitle: Text("Suggested by AI",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey.shade600)),
                      trailing: ElevatedButton(
                        onPressed: () =>
                            startVideoCall(contact["name"]!, contact["phone"]!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Text("Call",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontWeight: FontWeight.w600)),
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
