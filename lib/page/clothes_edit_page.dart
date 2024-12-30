import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/widget/common/piece_placement_picker.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/common/style_picker.dart';
import 'package:ooo_fit/widget/outfit_clothes/label_button.dart';

class ClothesEditPage extends StatelessWidget {
  final Piece? piece;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  ClothesEditPage({
    super.key,
    this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: SizedBox(
          width: double.infinity,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter name',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
      body: ContentFrameDetail(
        children: [
          _buildForm(),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.clothes),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 10),
          StylePicker(),
          SizedBox(height: 10),
          PiecePlacementPicker(),
          SizedBox(height: 10),
          FormBuilderImagePicker(
            name: 'image',
            maxImages: 1,
          ),
          PageDivider(),
          LabelButton(
            label: "Save",
            backgroundColor: Colors.transparent,
            textColor: Colors.deepPurple,
            onPressed: _handleSave,
          ),
          SizedBox(height: 20),
          LabelButton(
            label: "Delete",
            backgroundColor: Colors.transparent,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (piece == null) {
        final Map<String, dynamic> formData = _formKey.currentState!.value;

        final imageList = formData['image'];
        if (imageList != null && imageList.isNotEmpty) {
          final imagePath = (imageList.first as XFile).path;

          String? error = await _pieceService.savePiece(
            name: formData['name'],
            piecePlacement: formData['piecePlacement'],
            styleIds: formData['styleIds'],
            imagePath: imagePath,
          );
          print(error);
        } else {
          print("No photo selected");
        }
      }
    } else {
      print("Validation failed");
    }
  }
}
