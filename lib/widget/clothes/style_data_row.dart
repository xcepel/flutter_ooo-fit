import 'package:flutter/material.dart';

class StyleDataRow extends StatelessWidget {
  final List<String> items;

  const StyleDataRow({required this.items});

  @override
  Widget build(BuildContext context) {
    // Split items into rows of 3
    List<List<String>> rows = [];
    for (int i = 0; i < items.length; i += 3) {
      rows.add(items.sublist(i, i + 3 > items.length ? items.length : i + 3));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows.map((rowItems) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowItems.map((item) => _dotText(item)).toList(),
        );
      }).toList(),
    );
  }
}

Widget _dotText(String text) {
  return Expanded(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
