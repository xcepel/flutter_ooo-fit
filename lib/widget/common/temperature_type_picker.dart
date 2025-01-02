import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ooo_fit/model/temperature_type.dart';

class TemperatureTypePicker extends StatelessWidget {
  final TemperatureType? selectedTemperatureType;
  const TemperatureTypePicker({super.key, this.selectedTemperatureType});

  @override
  Widget build(BuildContext context) {
    return FormBuilderChoiceChip(
      name: 'temperature',
      options: _getTemperatureChipOptions(),
      initialValue: selectedTemperatureType,
      decoration: InputDecoration(labelText: 'Temperature'),
    );
  }

  List<FormBuilderChipOption<TemperatureType>> _getTemperatureChipOptions() {
    return TemperatureType.values
        .map((TemperatureType tempType) => FormBuilderChipOption(
              value: tempType,
              avatar: tempType.icon,
              child: Text(tempType.name),
            ))
        .toList();
  }
}
