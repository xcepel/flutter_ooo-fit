import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const DeleteConfirmDialog({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Do you really want to delete this?"),
      content: const Text("This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red.shade900),
          ),
        ),
      ],
    );
  }
}
