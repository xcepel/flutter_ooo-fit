import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/pieces/piece_edit_form.dart';

class PieceEditPage extends StatelessWidget {
  final Piece? piece;

  const PieceEditPage({
    super.key,
    this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ContentFrameDetail(
        children: [
          PieceEditForm(piece: piece),
        ],
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.pieces),
    );
  }
}
