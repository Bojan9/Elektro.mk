import 'package:flutter/material.dart';
import 'package:elektro/models/electric_charge.dart';
import 'package:elektro/widgets/info_tab.dart';
import 'package:elektro/widgets/chargers_tab.dart';

class StationSinglePage extends StatefulWidget {
  final ElectricCharge charger;

  const StationSinglePage({super.key, required this.charger});

  @override
  // ignore: library_private_types_in_public_api
  _StationSinglePageState createState() => _StationSinglePageState();
}

class _StationSinglePageState extends State<StationSinglePage> {
  bool _showInfoTab = true;

  @override
  Widget build(BuildContext context) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.charger.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Image.asset(
              'assets/images/charger_placeholder.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            // Station Name
            Center(
              child: Text(
                widget.charger.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // Location and Availability
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on),
                  Text(widget.charger.location),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.charger.isOpen ? 'Open' : 'Closed'),
                  const SizedBox(width: 10),
                  Text(capitalize(widget.charger.roadAccess)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Navigation Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showInfoTab = true;
                    });
                  },
                  child: const Text('Info'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showInfoTab = false;
                    });
                  },
                  child: const Text('Chargers'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Content based on selected tab
            _showInfoTab ? InfoTab(charger: widget.charger) : ChargersTab(charger: widget.charger),
          ],
        ),
      ),
    );
  }
}
