import 'package:flutter/material.dart';
import 'package:ooo_fit/utils/constants.dart';

class PageContentFrame extends StatelessWidget {
  final List<Widget> children;

  const PageContentFrame({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
