import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  String janeStatus = "";
  List<String> memoryImagesBase64 = [];
  String memoryDate = "";

  List<Map<String, dynamic>> contacts = [
    {"name": "Angelo", "phone": "123456789", "imageBytes": null},
    {"name": "Florineiosann", "phone": "+40741949594", "imageBytes": null},
    {"name": "Aly", "phone": "555123456", "imageBytes": null},
  ];

  bool _isStatusLoading = true;
  bool _isMemoryStatusLoading = true;

  String _error = "";
  String _memoryImagesError = "";
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchJaneStatus();
    fetchMemoryFlashbacks();
    fetchContactImages();
  }

  void fetchJaneStatus() async {
    setState(() {
      _isStatusLoading = true;
      _error = '';
    });

    try {
      final data = await ApiService.fetchWhatAmIDoing();
      setState(() {
        janeStatus = data['message'] ?? 'No activity detected.';
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load activity.';
      });
    }
    setState(() {
      _isStatusLoading = false;
    });
  }

  Uint8List decodeBase64Image(String base64String) {
    final regex = RegExp(r'data:image/[^;]+;base64,');
    final cleanedBase64 = base64String.replaceAll(regex, '');
    return base64Decode(cleanedBase64);
  }

  void fetchContactImages() async {
    try {
      final data = await ApiService.fetchContactsImages();
      final images = data['images'];

      setState(() {
        contacts[0]['imageBytes'] = decodeBase64Image(images['image_1']);
        contacts[1]['imageBytes'] = decodeBase64Image(images['image_2']);
        contacts[2]['imageBytes'] = decodeBase64Image(images['image_3']);
      });
    } catch (e) {
      print("Failed to load contact images: $e");
    }
  }

  void fetchMemoryFlashbacks() async {
    setState(() {
      _isMemoryStatusLoading = true;
      _memoryImagesError = '';
    });

    try {
      final data = await ApiService.fetchMemoryFlasbacks();
      setState(() {
        memoryDate = data['date'] ?? '';
        memoryImagesBase64 = [
          data['images']['image_1'],
          data['images']['image_2'],
          data['images']['image_3'],
        ].where((img) => img != null && img.toString().isNotEmpty).cast<String>().toList();
      });
    } catch (e) {
      setState(() {
        _memoryImagesError = 'Failed to load memory images.';
      });
    } finally {
      setState(() {
        _isMemoryStatusLoading = false;
      });
    }
  }

  void openCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      print('Photo path: ${photo.path}');
    }
  }

  void openDoctorApp() async {
    final uri = Uri.parse("app://doctorapp");
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  void openGames() async {
    final uri = Uri.parse("app://games");
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  void contactOptions(String name, String phone) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Contact $name", style: GoogleFonts.poppins()),
        actions: [
          TextButton.icon(
            onPressed: () => launchUrl(Uri.parse("tel:$phone")),
            icon: Icon(Icons.call),
            label: Text("Call", style: GoogleFonts.poppins()),
          ),
          TextButton.icon(
            onPressed: () => launchUrl(Uri.parse("sms:$phone")),
            icon: Icon(Icons.sms),
            label: Text("Message", style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  void openGeneralCall() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Call someone", style: GoogleFonts.poppins()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...contacts.map((c) => ListTile(
              leading: Icon(Icons.person),
              title: Text(c['name']!, style: GoogleFonts.poppins()),
              onTap: () => launchUrl(Uri.parse("tel:${c['phone']!}")),
            )),
            Divider(),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text("Emergency - 911", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              onTap: () => launchUrl(Uri.parse("tel:911")),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMemoryImages() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: memoryImagesBase64.map((b64) {
          try {
            final bytes = decodeBase64Image(b64);
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.memory(bytes, width: 80, height: 80),
            );
          } catch (_) {
            return Container();
          }
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final now = DateTime.now();
    final dateStr = DateFormat('MMMM d, yyyy').format(now);
    final timeStr = DateFormat('h:mm a').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Today is $dateStr\n$timeStr",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: screenSize.width * 0.055),
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton.icon(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  fetchJaneStatus();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Jane's Status", style: GoogleFonts.poppins()),
                      content: Text(
                        !_isStatusLoading
                            ? 'Loading...'
                            : (_error.isNotEmpty ? _error : janeStatus),
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                label: Text(
                  "What is Jane Doing?",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: screenSize.width * 0.04),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              if (_isMemoryStatusLoading)
                CircularProgressIndicator()
              else if (memoryImagesBase64.isNotEmpty)
                buildMemoryImages(),
              if (memoryDate.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Memory flashback $memoryDate",
                    style: GoogleFonts.poppins(
                      fontSize: screenSize.width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                "Default Options",
                style: GoogleFonts.poppins(
                  fontSize: screenSize.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildActionButton("Camera", Icons.camera_alt, openCamera),
                    SizedBox(width: 10),
                    _buildActionButton("Doctor", Icons.local_hospital, openDoctorApp),
                    SizedBox(width: 10),
                    _buildActionButton("Games", Icons.videogame_asset, openGames),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Important Contacts:",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.045,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Container(
                height: screenSize.height * 0.1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: contacts.asMap().entries.map((entry) {
                    int index = entry.key;
                    var c = entry.value;

                    return GestureDetector(
                      onTap: () => contactOptions(c['name']!, c['phone']!),
                      child: Container(
                        width: screenSize.width * 0.3,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: c['imageBytes'] != null
                                  ? MemoryImage(c['imageBytes'])
                                  : null,
                              radius: 24,
                              backgroundColor: Colors.white,
                              child: c['imageBytes'] == null
                                  ? Icon(Icons.person, color: Colors.grey)
                                  : null,
                            ),
                            SizedBox(height: 4),
                            Text(
                              c['name']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/all-options'),
              icon: Icon(Icons.arrow_back),
              tooltip: 'Back to Options',
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home, color: Colors.green),
              tooltip: 'Home',
            ),
            IconButton(
              onPressed: openGeneralCall,
              icon: Icon(Icons.phone, color: Colors.red),
              tooltip: 'Call someone',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(label, style: GoogleFonts.poppins(color: Colors.white)),
    );
  }
}
