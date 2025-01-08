import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/page/pieces_list_page.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/common/form/save_button.dart';
import 'package:ooo_fit/widget/common/form/delete_button.dart';
import 'package:ooo_fit/widget/common/form/image_picker.dart';
import 'package:ooo_fit/widget/common/form/name_form_field.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/common/form/style_picker.dart';
import 'package:ooo_fit/widget/pieces/piece_placement_picker.dart';

import 'package:ooo_fit/service/piece_service.dart';

class PieceEditForm extends StatelessWidget {
  final Piece? piece;
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  PieceEditForm({
    super.key,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
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
          ImagePicker(
            value: piece?.imagePath,
            isRequired: true,
          ),
          PageDivider(),
          SaveButton(onPressed: () => _handleSave(context)),
          SizedBox(height: 20),
          if (piece != null)
            DeleteButton(onPressed: () => _handleDelete(context)),
        ],
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    String? error = await _pieceService.deletePiece(piece: piece!);

    if (context.mounted) {
      handleActionResult(
        context: context,
        errorMessage: error,
        successMessage: "Piece was deleted successfully",
        onSuccessNavigation: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PiecesListPage(),
          ));
        },
      );
    }
  }

  Future<void> _handleSave(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;

      final imageList = formData['image'];
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

      if (context.mounted) {
        handleActionResult(
          context: context,
          errorMessage: error,
          successMessage: "Piece was saved successfully",
          onSuccessNavigation: () => Navigator.pop(context),
        );
      }
    }
  }
}
