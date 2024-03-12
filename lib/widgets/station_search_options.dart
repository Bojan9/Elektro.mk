import 'package:flutter/material.dart';

class StationSearchOptions extends StatelessWidget {
  final VoidCallback onPressed;

  const StationSearchOptions({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width / 7,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.tune,
            color: Color.fromRGBO(0, 171, 130, 1),
          )
        ),
      ),
    );
  }
}
