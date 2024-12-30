import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/clothes_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/clothes/style_data_row.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_clothes/description_label.dart';
import 'package:ooo_fit/widget/outfit_clothes/list_item.dart';
import 'package:ooo_fit/widget/outfit_clothes/sized_picture.dart';

class ClothesDetailPage extends StatelessWidget {
  final String pieceId;
  final PieceService _pieceService = GetIt.instance.get<PieceService>();
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  final String clothingPicture =
      "assets/images/purple_solid.png"; // TODO remove

  ClothesDetailPage({
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
            actionButton: EditButton(editPage: ClothesEditPage()),
          ),
          body: ContentFrameDetail(
            children: [
              _buildFuture<Style>(
                future: _getStyles(piece.styleIds),
                itemBuilder: (styles) => StyleDataRow(items: styles),
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
              // TODO az budou obrazky nacist
              LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.maxWidth;
                  return SizedPicture(
                    sizeX: size,
                    sizeY: size,
                    image: clothingPicture,
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
              CustomBottomNavigationBar(currentPage: PageTypes.clothes),
        );
      },
    );
  }

  Widget _buildFuture<T>({
    required Future<List<T>> future,
    required Widget Function(List<T>) itemBuilder,
  }) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available.');
        } else {
          return itemBuilder(snapshot.data!);
        }
      },
    );
  }

  Future<List<Style>> _getStyles(List<String> styleIds) async {
    final List<Style> allStyles =
        await _styleService.getAllStylesStream().first;
    return allStyles.where((style) => styleIds.contains(style.id)).toList();
  }
}
