import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/page/pieces_list_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/form/edit_form_wrapper.dart';
import 'package:ooo_fit/widget/common/page_formating/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/page_formating/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/pieces/piece_edit_form.dart';

class PieceEditPage extends StatelessWidget {
  final Piece? piece;

  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  PieceEditPage({
    super.key,
    this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ContentFrameDetail(
        children: [
          EditFormWrapper(
            onSaveSuccessMessage: "Piece was saved successfully",
            onDeleteSuccessMessage: "Piece was deleted successfully",
            onSave: handleSave,
            onDelete: piece != null ? handleDelete : null,
            onDeleteNavigationPage: PiecesListPage(),
            child: PieceEditForm(
              piece: piece,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.pieces),
    );
  }

  Future<String?> handleDelete() async {
    return await _pieceService.delete(piece!);
  }

  Future<String?> handleSave(Map<String, dynamic> formData) async {
    final imageList = formData['image'];

    String imagePath;
    // case when ImagePicker is displaying Piece's existing image (from URL)
    // imagePath can remain unchanged, since it is the image already in database
    if (imageList.first is String) {
      imagePath = piece!.imagePath;
    } else {
      // imageList.first is XFile
      imagePath = (imageList.first as XFile).path;
    }

    if (piece == null) {
      return await _pieceService.savePiece(
        name: formData['name'],
        piecePlacement: formData['piecePlacement'],
        styleIds: formData['styleIds'],
        imagePath: imagePath,
      );
    } else {
      return await _pieceService.updatePiece(
        piece: piece!,
        name: formData['name'],
        piecePlacement: formData['piecePlacement'],
        styleIds: formData['styleIds'],
        imagePath: imagePath,
      );
    }
  }
}
