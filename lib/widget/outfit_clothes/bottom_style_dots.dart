import 'package:flutter/material.dart';

class BottomStyleDots extends StatelessWidget {
  final List<Color> styleColors;

  final double position = 8.0;
  final double size = 15.0;

  const BottomStyleDots({super.key, required this.styleColors});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: position,
      left: position,
      child: Row(
        children: styleColors.map((color) {
          return Container(
            margin: const EdgeInsets.only(right: 4),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
          );
        }).toList(),
      ),
    );
  }
}
