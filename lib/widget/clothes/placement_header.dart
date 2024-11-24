import 'package:flutter/material.dart';

class PlacementHeader extends StatelessWidget {
  final String label;

  const PlacementHeader({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      width: double.infinity,
      color: Colors.deepPurpleAccent,
      child: Row(
        children: [
          Icon(
            Icons.view_headline, // TODO change for each
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
