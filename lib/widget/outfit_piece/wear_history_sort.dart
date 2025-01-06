import 'package:flutter/material.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class WearHistorySort extends StatelessWidget {
  final WearHistory? selectedHistorySort;
  final ValueChanged<String?> onChanged;

  const WearHistorySort({
    required this.selectedHistorySort,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFilter<String>(
      hint: "Wear History",
      value: selectedHistorySort?.label,
      items: [
        DropdownMenuItem<String>(
          value: "Default",
          child: Row(
            children: [Text("Default")],
          ),
        ),
        ...WearHistory.values.map((sort) => DropdownMenuItem<String>(
              value: sort.label,
              child: Row(
                children: [
                  Icon(sort.picture),
                  SizedBox(width: 5),
                  Text(sort.label),
                ],
              ),
            )),
      ],
      onChanged: onChanged,
    );
  }
}
