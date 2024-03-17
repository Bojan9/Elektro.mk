import 'package:elektro/models/electric_charge.dart';
import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  final ElectricCharge charger;

  const InfoTab({super.key, required this.charger});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoItem('Parking', charger.parking, false),
                _buildInfoItem('Access', charger.paymentAccess, false),
                _buildInfoItem('Cost', charger.connectorInfo[0].tariff, false),
                _buildInfoItem('Limit', charger.limit, true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: const Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 10),
                      Text(
                        'Working Hours',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  children: [
                    _buildInfoItem('Monday', '00:00 - 00:00', true),
                    _buildInfoItem('Tuesday', '00:00 - 00:00', true),
                    _buildInfoItem('Wednesday', '00:00 - 00:00', true),
                    _buildInfoItem('Thursday', '00:00 - 00:00', true),
                    _buildInfoItem('Friday', '00:00 - 00:00', true),
                    _buildInfoItem('Saturday', '00:00 - 00:00', true),
                    _buildInfoItem('Sunday', '00:00 - 00:00', true),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: const Text(
                    'Amenities',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: _buildAmenities(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Add the location map widget here
      ],
    );
  }

  List<Widget> _buildAmenities() {
  List<Widget> amenitiesWidgets = [];
  List<String> amenitiesList = charger.amenities;

  for (int i = 0; i < amenitiesList.length; i += 2) {
    if (i + 1 < amenitiesList.length) {
      amenitiesWidgets.add(
        Row(
          children: [
            Expanded(child: _buildAmenityItem(amenitiesList[i])),
            Expanded(child: _buildAmenityItem(amenitiesList[i + 1])),
          ],
        ),
      );
    } else {
      amenitiesWidgets.add(
        Row(
          children: [
            Expanded(child: _buildAmenityItem(amenitiesList[i])),
          ],
        ),
      );
    }
  }

  return amenitiesWidgets;
}

Widget _buildAmenityItem(String amenity) {
  IconData iconData = Icons.error; // Default icon
  // ignore: unused_local_variable
  String tooltip = '';

  // Map amenities to their respective icons
  if (amenity.toLowerCase().contains('restroom')) {
    iconData = Icons.wc; // Icon for restroom
    tooltip = 'Restroom';
  } else if (amenity.toLowerCase().contains('restaurant')) {
    iconData = Icons.restaurant; // Icon for restaurant
    tooltip = 'Restaurant';
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Icon(iconData),
        const SizedBox(height: 4),
        Text(
          amenity,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}

  Widget _buildInfoItem(String label, String value, bool isLast) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w100),
              ),
              Text(
                capitalize(value),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Divider(),
          ),
      ],
    );
  }
}
