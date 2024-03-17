import 'package:flutter/material.dart';

class StationSearchOptions extends StatelessWidget {
  final Function(String, String) onOptionSelected;

  const StationSearchOptions({super.key, required this.onOptionSelected, required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: PopupMenuButton<Map<String, String>>(
        onSelected: (Map<String, String> selectedOption) {
          onOptionSelected(selectedOption['criteria']!, selectedOption['value']!);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Map<String, String>>>[
          _buildFilterOption(context, 'Availability', 'availability', ['24/7', 'Other']),
          _buildFilterOption(context, 'Road Access', 'roadAccess', ['Public', 'Private']),
          _buildFilterOption(context, 'Payment Type', 'paymentType', ['Free', 'Paid']),
          _buildFilterOption(context, 'Payment Access', 'paymentAccess', ['EVN Charging Card', 'Other']),
          _buildFilterOption(context, 'Open/Close', 'isOpen', ['Open', 'Close']),
          _buildFilterOption(context, 'Parking', 'parking', ['Free', 'Paid']),
          _buildFilterOption(context, 'Number of Connectors', 'numConnectors', ['1', '2', '3']),
        ],
        child: Container(
          width: MediaQuery.of(context).size.width / 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.tune,
            color: Color.fromRGBO(0, 171, 130, 1),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<Map<String, String>> _buildFilterOption(
      BuildContext context, String title, String criteria, List<String> options) {
    return PopupMenuItem<Map<String, String>>(
      value: {'criteria': criteria, 'value': ''}, // Default value
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Wrap(
            spacing: 10,
            children: options.map((option) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, {'criteria': criteria, 'value': option});
                },
                child: Chip(
                  label: Text(option),
                  backgroundColor: Colors.grey[300],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
