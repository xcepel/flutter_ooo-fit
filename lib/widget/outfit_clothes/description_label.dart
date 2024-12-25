import 'package:flutter/material.dart';

class DescriptionLabel extends StatelessWidget {
  final String label;
  final String value;
  const DescriptionLabel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
        ),
        Expanded(
          child: Text(
            value,
          ),
        ),
      ],
    );
    // TODO add sized box?
  }
}
