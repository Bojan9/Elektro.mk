import 'package:elektro/models/electric_charge.dart';
import 'package:flutter/material.dart';

class StationSinglePage extends StatelessWidget {
  final ElectricCharge charger;

  const StationSinglePage({super.key, required this.charger});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(charger.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location: ${charger.location}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Coordinates: ${charger.coordinates}'),
              const SizedBox(height: 10),
              Text('Availability: ${charger.availability}'),
              const SizedBox(height: 10),
              Text('Road Access: ${charger.roadAccess}'),
              const SizedBox(height: 10),
              Text('Payment Type: ${charger.paymentType}'),
              const SizedBox(height: 10),
              Text('Payment Access: ${charger.paymentAccess}'),
              const SizedBox(height: 10),
              Text('Open: ${charger.isOpen ? 'Yes' : 'No'}'),
              const SizedBox(height: 10),
              Text('Parking: ${charger.parking}'),
              const SizedBox(height: 10),
              Text('Limit: ${charger.limit}'),
              const SizedBox(height: 10),
              Text('Number of Connectors: ${charger.numConnectors}'),
              const SizedBox(height: 10),
              const Text(
                'Connector Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: charger.connectorInfo
                    .map(
                      (info) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${info.id}'),
                          const SizedBox(height: 5),
                          Text('Type: ${info.type}'),
                          const SizedBox(height: 5),
                          Text('Tariff: ${info.tariff}'),
                          const SizedBox(height: 5),
                          Text('Power: ${info.power}'),
                          const SizedBox(height: 5),
                          Text('Condition: ${info.condition}'),
                          const Divider(),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
