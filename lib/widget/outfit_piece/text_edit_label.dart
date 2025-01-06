import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class TextEditLabel extends StatelessWidget {
  final String label;
  const TextEditLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text("$label: "),
        ),
        SizedBox(width: 8),
        DropdownFilter(
          label: label,
          data: [],
          onChanged: (String? value) {},
        ), // TODO CHANGE
      ],
    );
  }
}
