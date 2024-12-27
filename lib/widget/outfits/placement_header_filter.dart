import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class PlacementHeaderFilter extends StatelessWidget {
  final String label;
  final IconData iconType;

  const PlacementHeaderFilter(
      {required this.label, super.key, required this.iconType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      width: double.infinity,
      color: Colors.deepPurpleAccent,
      child: Row(
        children: [
          Icon(
            iconType,
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
          Spacer(), // push the buttons to the right
          DropdownFilter(label: "Style", whiteStyle: true),
          IconButton(
            // adds one carousel
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            // removes one carousel
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
