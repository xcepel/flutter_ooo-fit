import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final Widget editPage;

  const EditButton({
    super.key,
    required this.editPage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit_rounded),
      color: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => editPage),
        );
      },
    );
  }
}
