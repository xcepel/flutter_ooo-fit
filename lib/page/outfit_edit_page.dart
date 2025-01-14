import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/form/edit_form_wrapper.dart';
import 'package:ooo_fit/widget/common/page_formating/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/outfits/outfit_edit_form.dart';

class OutfitEditPage extends StatelessWidget {
  final Outfit? outfit;

  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();

  OutfitEditPage({
    super.key,
    this.outfit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ContentFrameDetail(
        children: [
          EditFormWrapper(
            onSaveSuccessMessage: "Outfit was saved successfully",
            onDeleteSuccessMessage: "Outfit was deleted successfully",
            onSave: handleSave,
            onDelete: outfit != null ? handleDelete : null,
            onDeleteNavigationPage: OutfitsListPage(),
            child: OutfitEditForm(
              outfit: outfit,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.outfits),
    );
  }

  Future<String?> handleDelete() async {
    return await _outfitService.delete(outfit!);
  }

  Future<String?> handleSave(Map<String, dynamic> formData) async {
    final imageList = formData['image'];
    print(imageList.toString());
    //TODO deduplicate
    String? imagePath;
    if (imageList != null && imageList.isNotEmpty && imageList.first != null) {
      // case when ImagePicker is displaying Piece's existing image (from URL)
      // imagePath can remain unchanged, since it is the image already in database
      if (imageList.first is String) {
        imagePath = outfit!.imagePath;
      } else {
        // imageList.first is XFile
        imagePath = (imageList.first as XFile).path;
      }
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

    if (outfit == null) {
      return await _outfitService.saveOutfit(
        name: formData['name'],
        styleIds: formData['styleIds'],
        pieceIds: allSelectedPieces,
        temperature: formData['temperature'],
        imagePath: imagePath,
      );
    } else {
      return await _outfitService.updateOutfit(
        outfit: outfit!,
        name: formData['name'],
        pieceIds: allSelectedPieces,
        styleIds: formData['styleIds'],
        temperature: formData['temperature'],
        imagePath: imagePath,
      );
    }
  }
}
