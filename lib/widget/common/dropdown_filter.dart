import 'package:flutter/material.dart';

class DropdownFilter<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const DropdownFilter({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<T>(
        hint: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(hint),
        ),
        value: value,
        items: items,
        onChanged: onChanged,
        underline: Container(),
      ),
    );
  }
}
