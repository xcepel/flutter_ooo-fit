import 'package:flutter/material.dart';

class StyleDot extends StatelessWidget {
  final double size;
  final int color;
  const StyleDot({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(color),
        shape: BoxShape.circle,
      ),
    );
  }
}
