import 'package:flutter/material.dart';

class GhostCard extends StatelessWidget {
  final double itemWidth;

  const GhostCard({super.key, required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: itemWidth,
        child: Card(
          color: Colors.transparent,
          child: Container(),
        ),
      ),
    );
  }
}
