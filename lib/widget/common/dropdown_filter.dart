import 'package:flutter/material.dart';

class DropdownFilter<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final double width;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const DropdownFilter({
    super.key,
    required this.hint,
    required this.value,
    required this.width,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      width: width,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<T>(
        hint: Padding(
          padding: EdgeInsets.only(left: 6),
          child: Expanded(
            child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        value: value,
        items: items,
        onChanged: onChanged,
        underline: Container(),
        isExpanded: true,
      ),
    );
  }
}
