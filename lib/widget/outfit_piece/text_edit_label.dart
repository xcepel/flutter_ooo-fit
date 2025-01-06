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
        DropdownFilter<String>(
          hint: '',
          value: null,
          items: [],
          onChanged: (Object? value) {},
        ), // TODO CHANGE
      ],
    );
  }
}
