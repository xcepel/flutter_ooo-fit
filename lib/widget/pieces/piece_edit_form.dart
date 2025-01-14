import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:ooo_fit/widget/common/form/image_picker.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/form/piece_placement_picker.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';

class PieceEditForm extends StatelessWidget {
  final Piece? piece;

  const PieceEditForm({
    super.key,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameFormField(
          value: piece?.name,
          isRequired: true,
        ),
        SizedBox(height: 10),
        StylePicker(selectedStyles: piece?.styleIds),
        SizedBox(height: 10),
        PiecePlacementPicker(selectedPlacement: piece?.piecePlacement),
        SizedBox(height: 10),
        LoadingFutureBuilder(
          future: _buildImagePicker(),
          builder: (context, imagePicker) => imagePicker,
        ),
      ],
    );
  }

  Future<Widget> _buildImagePicker() async {
    String? downloadURL;
    if (piece != null) {
      downloadURL = await getImageDownloadURL(piece!.imagePath);
    }
    return ImagePicker(
      value: downloadURL,
      isRequired: true,
    );
  }
}
