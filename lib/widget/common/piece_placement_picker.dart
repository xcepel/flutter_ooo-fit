import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/widget/common/style_picker.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/label_button.dart';

class PiecePlacementPicker extends StatelessWidget {
  const PiecePlacementPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderChoiceChip(
        name: 'piecePlacement',
        decoration: const InputDecoration(labelText: 'Placement'),
        options: PiecePlacement.values
            .map((PiecePlacement placement) => FormBuilderChipOption(
                  value: placement,
                  child: Text(placement.name),
                ))
            .toList());
  }
}
