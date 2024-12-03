import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/custom_search_bar.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class PlacementHeaderFilter extends StatelessWidget {
  final String label;

  const PlacementHeaderFilter({required this.label, super.key});

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
          Spacer(), // push the buttons to the right
          Expanded(
            child: CustomSearchBar(whiteStyle: true),
          ),
          SizedBox(width: 10),
          DropdownFilter(label: "Style", whiteStyle: true),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              side: WidgetStateProperty.all(
                  BorderSide(color: Colors.white, width: 2)),
            ),
            child: const Text(
              'Random',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
