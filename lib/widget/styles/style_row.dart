import 'package:flutter/material.dart';

class StyleRow extends StatelessWidget {
  final String label;

  const StyleRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_rounded),
            onPressed: () {},
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.delete_rounded),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
