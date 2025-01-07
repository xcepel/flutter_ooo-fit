import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/widget/styles/style_dot.dart';

class BottomData extends StatelessWidget {
  final List<Style> styles;
  final TemperatureType? temperature;
  final PiecePlacement? placement;

  final double position = 8.0;
  final double size = 15.0;

  const BottomData({
    super.key,
    required this.styles,
    this.placement,
    this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: position,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: position),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: styles.map((Style style) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: StyleDot(size: size, color: style.color, border: true),
                );
              }).toList(),
            ),
            _buildRightCorner(),
          ],
        ),
      ),
    );
  }

  Widget _buildRightCorner() {
    if (placement != null) {
      return Image.asset(
        placement!.picture,
        color: Colors.black,
        width: 30,
        height: 30,
        fit: BoxFit.contain,
      );
    } else if (temperature != null) {
      return temperature!.icon;
    }
    return SizedBox(); // Fallback widget
  }
}
