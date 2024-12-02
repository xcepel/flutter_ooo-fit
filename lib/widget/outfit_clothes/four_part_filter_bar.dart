import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class FourPartFilterBar extends StatelessWidget {
  final String filter1;
  final String filter2;
  final String filter3;
  static const double _filterSpace = 10.0;

  const FourPartFilterBar(
      {super.key,
      required this.filter1,
      required this.filter2,
      required this.filter3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: _filterSpace),
      child: Row(
        children: [
          // Filter TextField
          const Expanded(
            flex: 1,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Filter Dropdowns
          Padding(
            padding: const EdgeInsets.only(left: _filterSpace),
            child: Expanded(
              flex: 1,
              child: Wrap(
                spacing: _filterSpace,
                children: [
                  DropdownFilter(label: filter1),
                  DropdownFilter(label: filter2),
                  DropdownFilter(label: filter3),
                  FloatingActionButton(
                    onPressed: () {},
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
