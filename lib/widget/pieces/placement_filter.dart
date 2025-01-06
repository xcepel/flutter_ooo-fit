import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';

class PlacementFilter extends StatelessWidget {
  final PiecePlacement? selectedPlacement;
  final ValueChanged<PiecePlacement?> onPlacementChanged;

  const PlacementFilter({
    required this.selectedPlacement,
    required this.onPlacementChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFilter<String>(
      hint: "Placement",
      value: selectedPlacement?.label,
      items: [
        DropdownMenuItem<String>(
          value: "All",
          child: Row(
            children: [SizedBox(width: 5), Text("All")],
          ),
        ),
        ...PiecePlacement.values.map((placement) => DropdownMenuItem<String>(
              value: placement.label,
              child: Row(
                children: [
                  Image.asset(
                    placement.picture,
                    width: 30,
                    height: 30,
                    color: Colors.black,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 5),
                  Text(placement.label),
                ],
              ),
            )),
      ],
      onChanged: (String? newValue) {
        final selected = newValue == "All"
            ? null
            : PiecePlacement.values.firstWhere(
                (placement) => placement.label == newValue,
              );
        onPlacementChanged(selected);
      },
    );
  }
}
