import 'package:flutter/material.dart';

class StationSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const StationSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search station',
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
