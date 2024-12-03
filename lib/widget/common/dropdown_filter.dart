import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String label;
  final bool whiteStyle;

  const DropdownFilter(
      {super.key, required this.label, this.whiteStyle = false});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(
        label,
        style: TextStyle(
          color: whiteStyle ? Colors.white : Colors.black,
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'type1',
          child: Text('type1'),
        ),
      ],
      onChanged: (_) {},
    );
  }
}
