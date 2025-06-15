import 'dart:math';
import 'package:flutter/material.dart';

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
  final rand = Random();
  final plantTypes = ['Tomato', 'Carrot', 'Sunflower'];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌿 Smart Garden'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Plant'),
                onPressed: plantNew,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.water_drop),
                label: const Text('Water'),
                onPressed: waterPlants,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_basket),
                label: const Text('Harvest'),
                onPressed: harvestPlants,
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: garden.isEmpty
                ? const Center(child: Text('🌱 Your garden is empty.'))
                : ListView.builder(
              itemCount: garden.length,
              itemBuilder: (context, index) {
                final plant = garden[index];
                return ListTile(
                  leading: Icon(
                    plant.isReadyToHarvest
                        ? Icons.local_florist
                        : Icons.eco,
                    color: plant.isReadyToHarvest
                        ? Colors.amber
                        : Colors.green,
                  ),
                  title: Text(plant.name),
                  subtitle:
                  Text('Growth: ${plant.growth}/${plant.maxGrowth}'),
                  trailing: plant.isReadyToHarvest
                      ? const Text('🌼 Ready!',
                      style: TextStyle(fontWeight: FontWeight.bold))
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
