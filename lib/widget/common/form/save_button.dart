import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LabelButton(
      label: "Save",
      backgroundColor: Colors.transparent,
      textColor: Colors.deepPurple,
      onPressed: onPressed,
    );
  }
}
