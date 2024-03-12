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
      /**
       * FIXME:
       * Handle error
       */
      print('Error loading chargers (exit app): $e');
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle options button pressed
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StationSearch(
                      onChanged: filterChargers,
                    ),
                  ),
                  const SizedBox(width: 10),
                  StationSearchOptions(
                    onPressed: () {
                      // Handle options button pressed
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: displayedChargers.isEmpty
                  ? const Center(
                      /**
             * FIXME:
             * When no stations found, add an image asset
             */
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: displayedChargers.length,
                      itemBuilder: (context, index) {
                        final charger = displayedChargers[index];
                        return ListTile(
                          title: Text(charger.name),
                          subtitle: Text(charger.location),
                          trailing: Text('ID: ${charger.id}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StationSinglePage(
                                    charger: displayedChargers[index]),
                              ),
                            );
                          },
                        );
                      },
                    ),
            )
          ],
        ));
  }
}
