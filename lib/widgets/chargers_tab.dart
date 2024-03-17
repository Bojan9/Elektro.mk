import 'package:elektro/models/electric_charge.dart';
import 'package:flutter/material.dart';

class ChargersTab extends StatelessWidget {
  final ElectricCharge charger;

  const ChargersTab({super.key, required this.charger});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Chargers',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        for (var i = 0; i < charger.connectorInfo.length; i++) ...[
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
                  _buildInfoItem('ID', charger.connectorInfo[i].id, false),
                  _buildInfoItem('Type', charger.connectorInfo[i].type, false),
                  _buildInfoItem('Tariff', charger.connectorInfo[i].tariff, false),
                  _buildInfoItem('Power', charger.connectorInfo[i].power, false),
                  _buildInfoItem('Condition', charger.connectorInfo[i].condition, true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ],
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
