import 'package:flutter/material.dart';

class DropdownFilter extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> data;
  final ValueChanged<String?> onChanged;
  final bool whiteStyle;

  const DropdownFilter({
    super.key,
    required this.label,
    required this.data,
    required this.onChanged,
    this.value,
    this.whiteStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        hint: Text(
          label,
          style: TextStyle(
            color: whiteStyle ? Colors.white : Colors.black,
          ),
        ),
        value: value,
        items: ["All", ...data]
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (String? newValue) {
          onChanged(newValue == "All" ? null : newValue);
        },
        underline: Container(),
      ),
    );
  }
}
