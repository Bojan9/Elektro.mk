import 'dart:io';
import 'package:elektro/models/electric_charge.dart';
import 'package:elektro/views/station_single.dart';
import 'package:elektro/widgets/station_search.dart';
import 'package:elektro/widgets/station_search_options.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class StationListPage extends StatefulWidget {
  const StationListPage({super.key});

  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  late List<ElectricCharge> allChargers;
  late List<ElectricCharge> displayedChargers = [];

  @override
  void initState() {
    super.initState();
    loadChargers();
  }

  Future<void> loadChargers() async {
    try {
      // Load JSON file
      String data = await DefaultAssetBundle.of(context)
          .loadString('assets/charge_data.json');

      // Parse JSON
      Map<String, dynamic> jsonData = jsonDecode(data);
      List<dynamic> jsonChargers = jsonData['chargers'];
      setState(() {
        allChargers =
            jsonChargers.map((json) => ElectricCharge.fromJson(json)).toList();
        displayedChargers = List.from(allChargers);
      });
    } catch (e) {
      exit(1);
    }
  }

  void filterChargers(String query) {
    setState(() {
      displayedChargers = allChargers.where((charger) {
        return charger.name.toLowerCase().contains(query.toLowerCase()) ||
            charger.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void applyFilter(String criteria, String value) {
    setState(() {
      displayedChargers = allChargers.where((charger) {
        switch (criteria) {
          case 'availability':
            return charger.availability.toLowerCase() == value.toLowerCase();
          case 'roadAccess':
            return charger.roadAccess.toLowerCase() == value.toLowerCase();
          case 'paymentType':
            return charger.paymentType.toLowerCase() == value.toLowerCase();
          case 'paymentAccess':
            return charger.paymentAccess.toLowerCase() == value.toLowerCase();
          case 'isOpen':
            return charger.isOpen.toString().toLowerCase() == value.toLowerCase();
          case 'parking':
            return charger.parking.toLowerCase() == value.toLowerCase();
          case 'numConnectors':
            return charger.numConnectors.toString().toLowerCase() == value.toLowerCase();
          default:
            return true; // No filtering
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chargers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: StationSearch(
                    onChanged: filterChargers,
                  ),
                ),
                const SizedBox(width: 10),
                StationSearchOptions(
                  onOptionSelected: applyFilter, onPressed: () {  },
                ),
              ],
            ),
          ),
          Expanded(
            child: displayedChargers.isEmpty
                ? const Center(
                    child: Text("No station found :("),
                  )
                : ListView.builder(
                    itemCount: displayedChargers.length,
                    itemBuilder: (context, index) {
                      final charger = displayedChargers[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: Image.asset(
                              charger.availability == '24/7'
                                  ? 'assets/images/ec_open.png'
                                  : 'assets/images/ec_closed.png',
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                              charger.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(charger.location),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StationSinglePage(
                                    charger: displayedChargers[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
