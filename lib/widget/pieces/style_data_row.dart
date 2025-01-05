import 'package:flutter/material.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/widget/pieces/style_dot.dart';

class StyleDataRow extends StatelessWidget {
  final List<Style> items;

  const StyleDataRow({required this.items});

  @override
  Widget build(BuildContext context) {
    // Split items into rows of 3
    List<List<Style>> rows = [];
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

Widget _dotText(Style style) {
  return Expanded(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StyleDot(color: style.color),
        SizedBox(width: 8),
        Text(style.name),
      ],
    ),
  );
}
