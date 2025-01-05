import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/page/pieces_list_page.dart';
import 'package:ooo_fit/widget/pieces/piece_placement_picker.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/common/style_picker.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class PieceEditPage extends StatelessWidget {
  final Piece? piece;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  PieceEditPage({
    super.key,
    this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ContentFrameDetail(
        children: [
          _buildForm(context),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.pieces),
    );
  }

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Name'),
            initialValue: piece?.name,
          ),
          SizedBox(height: 10),
          StylePicker(
            selectedStyles: piece?.styleIds,
          ),
          SizedBox(height: 10),
          PiecePlacementPicker(
            selectedPlacement: piece?.piecePlacement,
          ),
          SizedBox(height: 10),
          FormBuilderImagePicker(
            name: 'image',
            maxImages: 1,
            initialValue: [piece?.imagePath],
            decoration: InputDecoration(labelText: 'Upload a photo'),
          ),
          PageDivider(),
          LabelButton(
            label: "Save",
            backgroundColor: Colors.transparent,
            textColor: Colors.deepPurple,
            onPressed: () => _handleSave(context),
          ),
          SizedBox(height: 20),
          // delete button is rendered only if the piece already exists
          if (piece != null)
            LabelButton(
              label: "Delete",
              backgroundColor: Colors.transparent,
              textColor: Colors.grey,
              onPressed: () => _handleDelete(context),
            ),
        ],
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    String? error = await _pieceService.deletePiece(piece: piece!);

    if (error == null) {
      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PiecesListPage(),
        ));
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error ?? "Piece was deleted successfully"),
      behavior: SnackBarBehavior.fixed,
    ));
  }

  Future<void> _handleSave(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;

      final imageList = formData['image'];
      if (imageList != null && imageList.isNotEmpty) {
        //TODO: image picker contains String path when updating
        String imagePath;
        if (imageList.first.runtimeType == String) {
          imagePath = imageList.first;
        } else {
          imagePath = (imageList.first as XFile).path;
        }

        String? error;
        if (piece == null) {
          error = await _pieceService.savePiece(
            name: formData['name'],
            piecePlacement: formData['piecePlacement'],
            styleIds: formData['styleIds'],
            imagePath: imagePath,
          );
        } else {
          error = await _pieceService.updatePiece(
            piece: piece!,
            name: formData['name'],
            piecePlacement: formData['piecePlacement'],
            styleIds: formData['styleIds'],
            imagePath: imagePath,
          );
        }

        if (error == null) {
          Navigator.pop(context);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error ?? "Piece was saved successfully"),
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
