import 'package:flutter/material.dart';

class DropdownFilterItemData extends StatelessWidget {
  final Widget icon;
  final String label;
  final double width;

  const DropdownFilterItemData({
    super.key,
    required this.icon,
    required this.label,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5),
        icon,
        SizedBox(width: 5),
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
