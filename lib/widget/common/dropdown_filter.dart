import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String label;

  const DropdownFilter({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(label),
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
