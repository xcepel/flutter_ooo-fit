import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ooo_fit/model/piece_placement.dart';

class PiecePlacementPicker extends StatelessWidget {
  final PiecePlacement? selectedPlacement;
  const PiecePlacementPicker({super.key, this.selectedPlacement});

  @override
  Widget build(BuildContext context) {
    return FormBuilderChoiceChip(
      name: 'piecePlacement',
      decoration: const InputDecoration(labelText: 'Placement'),
      initialValue: selectedPlacement,
      options: _getPlacementChipOptions(),
    );
  }

  List<FormBuilderChipOption<PiecePlacement>> _getPlacementChipOptions() {
    return PiecePlacement.values
        .map((PiecePlacement placement) => FormBuilderChipOption(
              value: placement,
              avatar: Image.asset(
                placement.picture,
                color: Colors.black,
              ),
              child: Text(placement.name),
            ))
        .toList();
  }
}
