import 'package:flutter/material.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:ooo_fit/widget/common/form/image_picker.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/common/form/temperature_type_picker.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:ooo_fit/widget/outfits/outfit_builder.dart';

class OutfitEditForm extends StatelessWidget {
  final Outfit? outfit;

  const OutfitEditForm({
    super.key,
    this.outfit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NameFormField(
          value: outfit?.name,
          isRequired: true,
        ),
        SizedBox(height: 10),
        StylePicker(selectedStyles: outfit?.styleIds),
        SizedBox(height: 10),
        TemperatureTypePicker(selectedTemperatureType: outfit?.temperature),
        OutfitBuilder(
          selectedPieceIds: outfit?.pieceIds,
        ),
        LoadingFutureBuilder(
          future: _buildImagePicker(),
          builder: (context, imagePicker) => imagePicker,
        ),
      ],
    );
  }

  Future<Widget> _buildImagePicker() async {
    String? downloadURL;
    if (outfit?.imagePath != null) {
      downloadURL = await getImageDownloadURL(outfit!.imagePath!);
    }
    return ImagePicker(
      value: downloadURL,
      isRequired: false,
    );
  }
}
