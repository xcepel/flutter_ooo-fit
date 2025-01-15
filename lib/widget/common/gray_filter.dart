import 'package:flutter/material.dart';

class GrayFilter extends StatelessWidget {
  final Widget photo;

  const GrayFilter({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.grey,
        BlendMode.saturation,
      ),
      child: photo,
    );
  }
}
