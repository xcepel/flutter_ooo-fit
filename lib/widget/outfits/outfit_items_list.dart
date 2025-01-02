import 'package:flutter/material.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/outfit_detail_page.dart';
import 'package:ooo_fit/widget/outfits/outfit_list_item.dart';

class OutfitItemsList extends StatelessWidget {
  final List<Outfit> outfits;
  final Map<String, Style> styles;
  final Map<String, Piece>
      pieces; // TODO tohle bude potreba pro tisk matic, bude se to predavat

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

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: outfits.map((Outfit outfit) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OutfitDetailPage(
                      outfitId: outfit.id,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: itemWidth,
                child: OutfitListItem(
                  outfit: outfit,
                  outfitStyles: _getStyles(outfit.styleIds),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Style> _getStyles(List<String> styleIds) {
    return styleIds.map((String styleId) => styles[styleId]!).toList();
  }
}
