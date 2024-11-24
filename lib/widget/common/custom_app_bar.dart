import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionButton;
  const CustomAppBar({super.key, required this.title, this.actionButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: actionButton != null ? [actionButton!] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
