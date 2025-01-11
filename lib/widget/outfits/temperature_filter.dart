import 'package:flutter/material.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/common/dropdown_filter_item_data.dart';

class TemperatureFilter extends StatelessWidget {
  final TemperatureType? selectedTemperature;
  final ValueChanged<TemperatureType?> onTemperatureChanged;
  final double width;

  const TemperatureFilter({
    super.key,
    required this.selectedTemperature,
    required this.onTemperatureChanged,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFilter<String>(
      hint: "Temp",
      value: selectedTemperature?.label,
      width: width,
      items: [
        DropdownMenuItem<String>(
          value: "All",
          child: Row(
            children: [SizedBox(width: 5), Text("All")],
          ),
        ),
        ...TemperatureType.values.map((temperature) => DropdownMenuItem<String>(
              value: temperature.label,
              child: DropdownFilterItemData(
                icon: temperature.icon,
                label: temperature.label,
                width: width,
              ),
            )),
      ],
      onChanged: (String? newValue) {
        final selected = newValue == "All"
            ? null
            : TemperatureType.values.firstWhere(
                (temperature) => temperature.label == newValue,
              );
        onTemperatureChanged(selected);
      },
    );
  }
}
