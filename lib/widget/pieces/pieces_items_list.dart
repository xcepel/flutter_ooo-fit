import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/page/piece_detail_page.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/common/ghost_card.dart';
import 'package:ooo_fit/widget/common/info_bubble.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_navigation_tile.dart';
import 'package:ooo_fit/widget/pieces/piece_list_item.dart';

class PiecesItemsList extends StatelessWidget {
  final bool fromOutfitDetail;
  final List<Piece> pieces;
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  PiecesItemsList({
    super.key,
    required this.pieces,
    this.fromOutfitDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width / 2 - 16; // 2 items per row

    return SingleChildScrollView(
      child: pieces.isEmpty
          ? _buildHelpInfo()
          : Wrap(spacing: 8, runSpacing: 8, children: [
              ...pieces.map((Piece piece) {
                return LoadingStreamBuilder(
                  stream:
                      _styleService.getPiecesStylesByIdsStream(piece.styleIds),
                  builder: (context, stylesList) {
                    return PageNavigationTile(
                      dstPage: PieceDetailPage(pieceId: piece.id),
                      child: SizedBox(
                        width: itemWidth,
                        child: PieceListItem(
                          piece: piece,
                          pieceStyles: stylesList,
                        ),
                      ),
                    );
                  },
                );
              }),
              if (pieces.length == 1) GhostCard(itemWidth: itemWidth),
            ]),
    );
  }

  Widget _buildHelpInfo() {
    return Column(
      children: [
        SizedBox(height: fromOutfitDetail ? 0 : 20),
        InfoBubble(
          message: fromOutfitDetail
              ? "Your outfit does not have any pieces.\nAdd them now!"
              : "There are no pieces with this type.\nYou can add piece using + button.\nTry it now!",
        )
      ],
    );
  }
}
