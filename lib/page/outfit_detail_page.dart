import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/pieces/pieces_items_list.dart';
import 'package:ooo_fit/widget/pieces/style_data_row.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_piece/description_label.dart';
import 'package:ooo_fit/widget/outfit_piece/sized_picture.dart';

class OutfitDetailPage extends StatelessWidget {
  final String outfitId;

  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();
  final PieceService _pieceService = GetIt.instance.get<PieceService>();
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  OutfitDetailPage({
    super.key,
    required this.outfitId,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _outfitService.getOutfitByIdStream(outfitId),
      builder: (context, outfit) {
        return Scaffold(
          appBar: CustomAppBar(
            title: outfit!.name ?? "",
            actionButton: EditButton(
                editPage: OutfitEditPage(
              outfit: outfit,
            )),
          ),
          body: ContentFrameDetail(
            children: [
              LoadingFutureBuilder(
                future: _getStyles(outfit.styleIds),
                builder: (context, styles) => StyleDataRow(items: styles),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  outfit.temperature.icon,
                  Text(outfit.temperature.label),
                ],
              ),
              const SizedBox(height: 10),
              DescriptionLabel(
                label: "Last worn",
                value: outfit.lastWorn?.toString() ?? "---",
              ),
              const SizedBox(height: 10),
              _addOutfitPicture(outfit.imagePath),
              const PageDivider(),
              const SizedBox(height: 5),
              LoadingFutureBuilder(
                future: _getPieces(outfit.pieceIds),
                builder: (context, pieces) =>
                    PiecesItemsList(piecesList: pieces),
              ),
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigationBar(currentPage: PageTypes.outfits),
        );
      },
    );
  }

  Widget _addOutfitPicture(String? outfitPicture) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth;
        return SizedPicture(
          sizeX: size,
          sizeY: size * 1.3,
          image: outfitPicture ?? '',
        );
      },
    );
  }

  Future<List<Style>> _getStyles(List<String> styleIds) async {
    final List<Style> allStyles =
        await _styleService.getAllStylesStream().first;
    return allStyles.where((style) => styleIds.contains(style.id)).toList();
  }

  Future<List<Piece>> _getPieces(List<String> pieceIds) async {
    final List<Piece> allPieces =
        await _pieceService.getAllPiecesStream().first;
    return allPieces.where((piece) => pieceIds.contains(piece.id)).toList();
  }
}
