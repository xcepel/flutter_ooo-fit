import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/piece_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/pieces/style_data_row.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_piece/description_label.dart';
import 'package:ooo_fit/widget/outfit_piece/list_item.dart';
import 'package:ooo_fit/widget/outfit_piece/sized_picture.dart';

class PieceDetailPage extends StatelessWidget {
  final String pieceId;
  final PieceService _pieceService = GetIt.instance.get<PieceService>();
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  PieceDetailPage({
    super.key,
    required this.pieceId,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _pieceService.getPieceByIdStream(pieceId),
      builder: (context, piece) {
        return Scaffold(
          appBar: CustomAppBar(
            title: piece!.name,
            actionButton: EditButton(
                editPage: PieceEditPage(
              piece: piece,
            )),
          ),
          body: ContentFrameDetail(
            children: [
              LoadingFutureBuilder(
                future: _getStyles(piece.styleIds),
                builder: (context, styles) => StyleDataRow(items: styles),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    piece.piecePlacement.picture,
                    color: Colors.black,
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  Text(piece.piecePlacement.label)
                ],
              ),
              SizedBox(height: 10),
              DescriptionLabel(
                label: "Last worn",
                value: piece.lastWorn.toString(), // TODO make prettier
              ),
              SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.maxWidth;
                  return SizedPicture(
                    sizeX: size,
                    sizeY: size,
                    image: piece.imagePath!,
                  );
                },
              ),
              PageDivider(),
              // TODO nevim jak to tahat. budeme to vubec ukazovat, nebo to nenapadne zahrabeme?
              DescriptionLabel(label: "In outfits", value: ""),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListItem(text: "outfit$index");
                },
              ),
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigationBar(currentPage: PageTypes.pieces),
        );
      },
    );
  }

  Future<List<Style>> _getStyles(List<String> styleIds) async {
    final List<Style> allStyles =
        await _styleService.getAllStylesStream().first;
    return allStyles.where((style) => styleIds.contains(style.id)).toList();
  }
}
