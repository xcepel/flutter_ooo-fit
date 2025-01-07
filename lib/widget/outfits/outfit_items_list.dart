import 'package:flutter/material.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/widget/common/ghost_card.dart';
import 'package:ooo_fit/widget/common/page_navigation_tile.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';

class OutfitItemsList extends StatelessWidget {
  final List<Outfit> outfits;
  final Map<String, Style> styles;
  final Map<String, Piece> pieces;

  const OutfitItemsList({
    super.key,
    required this.outfits,
    required this.styles,
    required this.pieces,
  });

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width / 2 - 16; // 2 items per row

    return SingleChildScrollView(
      child: Wrap(
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
}
