import 'package:flutter/material.dart';

class CreationFloatingButton extends StatelessWidget {
  final Widget? page;
  final VoidCallback? onPressed;

  const CreationFloatingButton({
    super.key,
    this.page,
    this.onPressed,
  }) : assert(page != null || onPressed != null);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
        }
      },
      child: const Icon(
        Icons.add,
        size: 35,
      ),
    );
  }
}
