import 'package:flutter/material.dart';

class StyleDot extends StatelessWidget {
  final double size;
  final int color;
  final bool border;
  const StyleDot({
    super.key,
    required this.size,
    required this.color,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(color),
        shape: BoxShape.circle,
        border:
            border == true ? Border.all(color: Colors.white, width: 1) : null,
      ),
    );
  }
}
