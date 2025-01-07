import 'package:flutter/material.dart';

class ChangeCityDialog extends StatelessWidget {
  const ChangeCityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Enter city"),
      insetPadding: EdgeInsets.all(10),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              _buildFormButtons(context),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildFormButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {},
          child: const Text('Save'),
        ),
      ],
    );
  }
}
