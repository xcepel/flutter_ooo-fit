import 'package:flutter/material.dart';

class TextEditLabel extends StatelessWidget {
  final String label;
  const TextEditLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(width: 8), // Space between label and TextField
        Expanded(
          child: TextField(
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(hintText: "Enter $label"),
          ),
        ),
      ],
    );
  }
}
