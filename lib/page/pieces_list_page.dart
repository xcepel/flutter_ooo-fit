import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/page/piece_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/pieces/pieces_items_list.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/creation_floating_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';

class PiecesListPage extends StatelessWidget {
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  PiecesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pieces list", weather_info: true),
      body: ContentFrameList(
        children: [
          DropdownFilter(
            label: "Placement",
            data: PiecePlacement.values
                .map((placement) => placement.label)
                .toList(),
            onChanged: (String? newFilter) {
              _pieceService.updatePlacementFilter(newFilter);
            },
          ),
          LoadingStreamBuilder<List<Piece>>(
            stream: _pieceService.getFilteredPiecesStream(),
            builder: (context, piecesList) {
              return Expanded(
                child: PiecesItemsList(pieces: piecesList),
              );
            },
          ),
        ],
      ),
      floatingActionButton: CreationFloatingButton(page: PieceEditPage()),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.pieces),
    );
  }
}
