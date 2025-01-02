import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/page/piece_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/pieces/pieces_items_list.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/custom_floating_action_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfit_piece/three_part_filter_bar.dart';

class PieceListPage extends StatelessWidget {
  final PieceService _pieceService = GetIt.instance.get<PieceService>();
  // TODO kvuli filtrovani to asi necham tady?

  PieceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pieces list", weather_info: true),
      body: ContentFrameList(
        children: [
          ThreePartFilterBar(
            filter1Name: "Style",
            filter2Name: "Placement",
            filter3Name: "Wear History",
          ),
          LoadingStreamBuilder<List<Piece>>(
            stream: _pieceService.getAllPiecesStream(),
            builder: (context, piecesList) {
              return Expanded(
                child: PiecesItemsList(piecesList: piecesList),
              );
            },
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PieceEditPage()));
        },
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.pieces),
    );
  }
}
