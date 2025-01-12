import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/common/form/delete_button.dart';
import 'package:ooo_fit/widget/common/form/image_picker.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/form/save_button.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/common/form/temperature_type_picker.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:ooo_fit/widget/outfits/outfit_builder.dart';

class OutfitEditForm extends StatelessWidget {
  final Outfit? outfit;
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  OutfitEditForm({
    super.key,
    this.outfit,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
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
          SaveButton(onPressed: () => {_handleSave(context)}),
          SizedBox(height: 20),
          if (outfit != null)
            DeleteButton(onPressed: () => {_handleDelete(context)}),
        ],
      ),
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

  Future<void> _handleDelete(BuildContext context) async {
    String? error = await _outfitService.delete(outfit!.id);

    if (context.mounted) {
      handleActionResult(
        context: context,
        errorMessage: error,
        successMessage: "Outfit was deleted successfully",
        onSuccessNavigation: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OutfitsListPage(),
          ));
        },
      );
    }
  }

  Future<void> _handleSave(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;

      final imageList = formData['image'];
      String? imagePath;
      if (imageList[0] != null) {
        final image = imageList.first;

        //TODO: refactor, for the love of god
        imagePath = image.runtimeType == String ? null : (image as XFile).path;
      }

      List<String> allSelectedPieces = [];
      for (PiecePlacement placement in PiecePlacement.values) {
        String fieldName = 'carousel_${placement.name}';
        List<String>? selectedPieces = formData[fieldName];
        //TODO: check sooner maybe
        if (selectedPieces != null) {
          allSelectedPieces
              .addAll(selectedPieces.where((id) => id.isNotEmpty).toList());
        }
      }

      String? error;
      if (outfit == null) {
        error = await _outfitService.saveOutfit(
          name: formData['name'],
          styleIds: formData['styleIds'],
          pieceIds: allSelectedPieces,
          temperature: formData['temperature'],
          imagePath: imagePath,
        );
      } else {
        error = await _outfitService.updateOutfit(
          outfit: outfit!,
          name: formData['name'],
          pieceIds: allSelectedPieces,
          styleIds: formData['styleIds'],
          temperature: formData['temperature'],
          imagePath: imagePath,
        );
      }

      if (context.mounted) {
        handleActionResult(
          context: context,
          errorMessage: error,
          successMessage: "Outfit was saved successfully",
          onSuccessNavigation: () => Navigator.pop(context),
        );
      }
    }
  }
}
