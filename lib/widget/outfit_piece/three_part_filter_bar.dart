import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class ThreePartFilterBar extends StatelessWidget {
  final String filter1Name;
  final String filter2Name;
  final String filter3Name;
  static const double _filterSpace = 15.0;

  const ThreePartFilterBar(
      {super.key,
      required this.filter1Name,
      required this.filter2Name,
      required this.filter3Name});

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
                DropdownFilter(
                  label: filter1Name,
                  data: [],
                  onChanged: (String? value) {},
                ), // TODO CHANGE
                DropdownFilter(
                  label: filter2Name,
                  data: [],
                  onChanged: (String? value) {},
                ), // TODO CHANGE
                DropdownFilter(
                  label: filter3Name,
                  data: [],
                  onChanged: (String? value) {},
                ), // TODO CHANGE
              ],
            ),
          ),
        ],
      ),
    );
  }
}
