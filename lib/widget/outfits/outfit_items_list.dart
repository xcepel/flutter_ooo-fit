import 'package:flutter/material.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/widget/common/ghost_card.dart';
import 'package:ooo_fit/widget/common/info_bubble.dart';
import 'package:ooo_fit/widget/common/page_navigation_tile.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';

class OutfitItemsList extends StatelessWidget {
  final bool fromPieceDetail;
  final List<Outfit> outfits;
  final Map<String, Style> styles;
  final Map<String, Piece> pieces;

  const OutfitItemsList({
    super.key,
    required this.outfits,
    required this.styles,
    required this.pieces,
    this.fromPieceDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width / 2 - 16; // 2 items per row

    return SingleChildScrollView(
      child: outfits.isEmpty
          ? _buildHelpInfo()
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...outfits.map((Outfit outfit) {
                  return PageNavigationTile(
                    dstPage: OutfitDetailPage(outfitId: outfit.id),
                    child: SizedBox(
                      width: itemWidth,
                      child: OutfitListItem(
                        outfit: outfit,
                      ),
                    ),
                  );
                }),
                if (outfits.length == 1) GhostCard(itemWidth: itemWidth),
              ],
            ),
    );
  }

  Widget _buildHelpInfo() {
    return Column(
      children: [
        SizedBox(height: fromPieceDetail ? 0 : 20),
        InfoBubble(
          message: fromPieceDetail
              ? "Your piece is not used in any outfits.\nAdd it now!"
              : "There are no outfits with this type.\nYou can add outfit using + button.\nTry it now!",
        )
      ],
    );
  }
}
