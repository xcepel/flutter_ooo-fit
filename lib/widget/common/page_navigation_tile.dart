import 'package:flutter/material.dart';

class PageNavigationTile extends StatelessWidget {
  final Widget? dstPage;
  final Widget child;

  const PageNavigationTile({
    super.key,
    required this.dstPage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dstPage == null
            ? null
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => dstPage!,
                ),
              );
      },
      child: child,
    );
  }
}
