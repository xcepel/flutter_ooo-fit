import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String text;

  const ListItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "- $text",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
