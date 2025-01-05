import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/common/style_picker.dart';
import 'package:ooo_fit/widget/common/temperature_type_picker.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';
import 'package:ooo_fit/widget/outfits/placement_piece_chooser.dart';

import 'package:ooo_fit/page/outfits_list_page.dart';

class OutfitEditPage extends StatelessWidget {
  final Outfit? outfit;
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  OutfitEditPage({super.key, this.outfit});

  @override
  Widget build(BuildContext context) {
    // TODO just for testing
    final List<String> pictureItemsData = [
      "assets/images/purple_solid.png",
      "assets/images/purple_solid.png",
      "assets/images/purple_solid.png",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ContentFrameDetail(
        children: [
          _buildForm(pictureItemsData, context),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.outfits),
    );
  }

  FormBuilder _buildForm(List<String> pictureItemsData, BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Name'),
            initialValue: outfit?.name,
          ),
          SizedBox(height: 10),
          StylePicker(
            selectedStyles: outfit?.styleIds,
          ),
          SizedBox(height: 10),
          TemperatureTypePicker(
            selectedTemperatureType: outfit?.temperature,
          ),
          PageDivider(),
          PlacementPieceChooser(
            details: PiecePlacement.head,
            piecesList: pictureItemsData,
          ),
          PlacementPieceChooser(
              details: PiecePlacement.neck, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.body, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.top, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.hands, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.waist, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.bottom, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.feet, piecesList: pictureItemsData),
          PlacementPieceChooser(
              details: PiecePlacement.other, piecesList: pictureItemsData),
          PageDivider(),
          FormBuilderImagePicker(
            name: 'image',
            maxImages: 1,
            initialValue: [outfit?.imagePath],
            decoration: InputDecoration(labelText: 'Upload a photo'),
          ),
          PageDivider(),
          _buildSaveButton(context),
          SizedBox(height: 20),
          _buildDeleteButton(context),
        ],
      ),
    );
  }

  LabelButton _buildDeleteButton(BuildContext context) {
    return LabelButton(
      label: "Delete",
      backgroundColor: Colors.transparent,
      textColor: Colors.grey,
      onPressed: () => _handleDelete(context),
    );
  }

  LabelButton _buildSaveButton(BuildContext context) {
    return LabelButton(
      label: "Save",
      backgroundColor: Colors.transparent,
      textColor: Colors.deepPurple,
      onPressed: () => _handleSave(context),
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    String? error = await _outfitService.deleteOutfit(outfit: outfit!);

    if (error == null) {
      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OutfitsListPage(),
        ));
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error ?? "Outfit was deleted successfully"),
      behavior: SnackBarBehavior.fixed,
    ));
  }

  Future<void> _handleSave(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;

      final imageList = formData['image'];
      if (imageList != null && imageList.isNotEmpty) {
        final imagePath = (imageList.first as XFile).path;

        String? error;
        if (outfit == null) {
          error = await _outfitService.saveOutfit(
            name: formData['name'],
            styleIds: formData['styleIds'],
            pieceIds: formData['pieceIds'],
            temperature: formData['temperature'],
            imagePath: imagePath,
          );
        } else {
          error = await _outfitService.updateOutfit(
            outfit: outfit!,
            name: formData['name'],
            pieceIds: formData['pieceIds'],
            styleIds: formData['styleIds'],
            temperature: formData['temperature'],
            imagePath: imagePath,
          );
        }

        if (error == null) {
          Navigator.pop(context);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error ?? "Outfit was saved successfully"),
          behavior: SnackBarBehavior.fixed,
        ));
      } else {
        print("No photo selected");
      }
    } else {
      print("Validation failed");
    }
  }
}
