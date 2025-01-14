import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;
  final int? color;

  const RoundButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: color != null
          ? ElevatedButton.styleFrom(backgroundColor: Color(color!))
          : null,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.grey),
            SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
