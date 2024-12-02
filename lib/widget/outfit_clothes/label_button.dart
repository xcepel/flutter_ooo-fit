import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const LabelButton(
      {super.key,
      required this.label,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: textColor, width: 2.0),
            ),
            backgroundColor: backgroundColor,
          ),
          onPressed: () {},
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
