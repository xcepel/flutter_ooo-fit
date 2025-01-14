import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/constants.dart';

class ContentFrameList extends StatelessWidget {
  final List<Widget> children;

  const ContentFrameList({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: Column(
        children: children,
      ),
    );
  }
}
