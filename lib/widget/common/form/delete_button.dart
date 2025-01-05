import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LabelButton(
      label: "Delete",
      backgroundColor: Colors.transparent,
      textColor: Colors.grey,
      onPressed: onPressed,
    );
  }
}
