import 'package:flutter/material.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/common/dropdown_filter_item_data.dart';

class WearHistorySort extends StatelessWidget {
  final WearHistory? selectedHistorySort;
  final ValueChanged<String?> onChanged;
  final double width;

  const WearHistorySort({
    super.key,
    required this.selectedHistorySort,
    required this.onChanged,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFilter<String>(
      hint: "History",
      value: selectedHistorySort?.label,
      width: width,
      items: [
        DropdownMenuItem<String>(
          value: "Default",
          child: Row(
            children: [Text("Default")],
          ),
        ),
        ...WearHistory.values.map((sort) => DropdownMenuItem<String>(
              value: sort.label,
              child: DropdownFilterItemData(
                icon: sort.icon,
                label: sort.label,
                width: width,
              ),
            )),
      ],
      onChanged: onChanged,
    );
  }
}
