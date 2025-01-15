import 'package:flutter/material.dart';

class DescriptionLabel extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? style;

  const DescriptionLabel({
    super.key,
    required this.label,
    required this.value,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: style ?? Theme.of(context).textTheme.bodyMedium,
        ),
        Expanded(
          child: Text(
            value,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
