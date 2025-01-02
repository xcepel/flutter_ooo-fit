import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/page/piece_detail_page.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/pieces/piece_list_item.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';

class PiecesItemsList extends StatelessWidget {
  final List<Piece> piecesList;
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  PiecesItemsList({super.key, required this.piecesList});

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width / 2 - 16; // 2 items per row

    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: piecesList.map((Piece piece) {
          return LoadingStreamBuilder(
            stream: _styleService.getPiecesStylesByIdsStream(piece.styleIds),
            builder: (context, stylesList) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PieceDetailPage(
                        pieceId: piece.id,
                      ),
                    ),
                  );
                },
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
        }).toList(),
      ),
    );
  }
}
