import 'package:flutter/material.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class TemperatureFilter extends StatelessWidget {
  final TemperatureType? selectedTemperature;
  final ValueChanged<TemperatureType?> onTemperatureChanged;

  const TemperatureFilter({
    required this.selectedTemperature,
    required this.onTemperatureChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFilter<String>(
      hint: "Temp",
      value: selectedTemperature?.label,
      items: [
        DropdownMenuItem<String>(
          value: "All",
          child: Row(
            children: [SizedBox(width: 5), Text("All")],
          ),
        ),
        ...TemperatureType.values.map((temperature) => DropdownMenuItem<String>(
              value: temperature.label,
              child: Row(
                children: [
                  temperature.icon,
                  SizedBox(width: 5),
                  Text(temperature.label),
                ],
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
