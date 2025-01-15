import 'package:flutter/material.dart';

class TopWarningData extends StatelessWidget {
  const TopWarningData({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.3),
        ),
        child: Icon(
          Icons.warning_amber_rounded,
          color: Colors.redAccent,
          size: 35,
        ),
      ),
    );
  }
}
