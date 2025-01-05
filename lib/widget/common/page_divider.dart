import 'package:flutter/material.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
      child: Divider(color: Colors.deepPurple),
    );
  }
}
