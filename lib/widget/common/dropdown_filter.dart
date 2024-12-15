import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String label;
  final bool whiteStyle;

  const DropdownFilter(
      {super.key, required this.label, this.whiteStyle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
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
        underline: Container(),
      ),
    );
  }
}
