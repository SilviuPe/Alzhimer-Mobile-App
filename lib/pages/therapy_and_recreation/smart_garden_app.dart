import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../global/speaker.dart';

class Plant {
  String name;
  int growth = 0;
  final int maxGrowth = 3;

  bool get isReadyToHarvest => growth >= maxGrowth;

  Plant(this.name);

  void water() {
    if (!isReadyToHarvest) {
      growth++;
    }
  }
}

class SmartGardenAppPage extends StatefulWidget {
  const SmartGardenAppPage({super.key});

  @override
  State<SmartGardenAppPage> createState() => _SmartGardenAppPageState();
}

class _SmartGardenAppPageState extends State<SmartGardenAppPage> {
  final List<Plant> garden = [];
  final Random rand = Random();
  final List<String> plantTypes = ['Tomato', 'Carrot', 'Sunflower'];

  @override
  void initState() {
    super.initState();
    generateAudioOutput();
  }

  @override
  void dispose() {
    Speaker.stop();
    super.dispose();
  }

  Future<void> generateAudioOutput() async {
    await Speaker.speak(
      "This is your beautiful garden. You can plant, water, and harvest. Have fun!",
    );
  }

  void plantNew() {
    final chosen = plantTypes[rand.nextInt(plantTypes.length)];
    setState(() {
      garden.add(Plant(chosen));
    });
  }

  void waterPlants() {
    setState(() {
      for (var plant in garden) {
        plant.water();
      }
    });
  }

  void harvestPlants() {
    setState(() {
      garden.removeWhere((p) => p.isReadyToHarvest);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🌿 Smart Garden',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 22, color: Colors.white),
                  label: Text('Plant', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: plantNew,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.water_drop, size: 22, color: Colors.white),
                  label: Text('Water', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: waterPlants,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_basket, size: 22, color: Colors.white),
                  label: Text('Harvest', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: harvestPlants,
                ),
              ],
            ),
          ),
          const Divider(thickness: 1.2),
          Expanded(
            child: garden.isEmpty
                ? Center(
              child: Text(
                '🌱 Your garden is empty.',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.deepPurple.shade300),
              ),
            )
                : ListView.builder(
              itemCount: garden.length,
              itemBuilder: (context, index) {
                final plant = garden[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(
                      plant.isReadyToHarvest ? Icons.local_florist : Icons.eco,
                      color: plant.isReadyToHarvest
                          ? Colors.amber.shade700
                          : Colors.green.shade700,
                      size: 30,
                    ),
                    title: Text(
                      plant.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                    subtitle: Text(
                      'Growth: ${plant.growth} / ${plant.maxGrowth}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.deepPurple.shade400,
                      ),
                    ),
                    trailing: plant.isReadyToHarvest
                        ? Text(
                      '🌼 Ready!',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.amber.shade800,
                      ),
                    )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
