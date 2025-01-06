import 'package:flutter/material.dart';

class DropdownFilter extends StatefulWidget {
  final String label;
  final List<String> data;
  final ValueChanged<String?> onChanged;
  final bool whiteStyle;

  const DropdownFilter({
    super.key,
    required this.label,
    required this.data,
    required this.onChanged,
    this.whiteStyle = false,
  });

  @override
  DropdownFilterState createState() => DropdownFilterState();
}

class DropdownFilterState extends State<DropdownFilter> {
  String? selectedValue;

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
          widget.label,
          style: TextStyle(
            color: widget.whiteStyle ? Colors.white : Colors.black,
          ),
        ),
        value: selectedValue == "All" ? null : selectedValue,
        items: ["All", ...widget.data]
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (String? newValue) {
          newValue == "All" ? newValue = null : newValue;

          setState(() {
            selectedValue = newValue;
          });
          widget.onChanged(selectedValue);
        },
        underline: Container(),
      ),
    );
  }
}
