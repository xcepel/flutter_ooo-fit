import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class ThreePartFilterBar extends StatelessWidget {
  final String filter1;
  final String filter2;
  final String filter3;
  static const double _filterSpace = 15.0;

  const ThreePartFilterBar(
      {super.key,
      required this.filter1,
      required this.filter2,
      required this.filter3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: _filterSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: _filterSpace),
            child: Wrap(
              spacing: _filterSpace,
              children: [
                DropdownFilter(label: filter1),
                DropdownFilter(label: filter2),
                DropdownFilter(label: filter3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
