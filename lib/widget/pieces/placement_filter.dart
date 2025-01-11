import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/common/dropdown_filter_item_data.dart';

class PlacementFilter extends StatelessWidget {
  final PiecePlacement? selectedPlacement;
  final ValueChanged<PiecePlacement?> onPlacementChanged;
  final double width;

  const PlacementFilter({
    super.key,
    required this.selectedPlacement,
    required this.onPlacementChanged,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownFilter<String>(
      hint: "Placement",
      value: selectedPlacement?.label,
      width: width,
      items: [
        DropdownMenuItem<String>(
          value: "All",
          child: Row(
            children: [SizedBox(width: 5), Text("All")],
          ),
        ),
        ...PiecePlacement.values.map((placement) => DropdownMenuItem<String>(
              value: placement.label,
              child: DropdownFilterItemData(
                icon: Image.asset(
                  placement.picture,
                  width: 30,
                  height: 30,
                  color: Colors.black,
                  fit: BoxFit.contain,
                ),
                label: placement.label,
                width: width,
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
