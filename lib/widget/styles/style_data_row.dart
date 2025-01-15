import 'package:flutter/material.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/widget/styles/style_dot.dart';

class StyleDataRow extends StatelessWidget {
  final List<Style> items;
  final int inOneRow;

  const StyleDataRow({required this.items, this.inOneRow = 3});
  @override
  Widget build(BuildContext context) {
    // Split items into rows of inOneRow (usually 3)
    List<List<Style>> rows = [];
    for (int i = 0; i < items.length; i += inOneRow) {
      rows.add(items.sublist(
          i, i + inOneRow > items.length ? items.length : i + inOneRow));
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
        StyleDot(size: 15, color: style.color),
        SizedBox(width: 8),
        Text(style.name),
      ],
    ),
  );
}
