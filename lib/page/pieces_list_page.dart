import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/page/piece_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/constants.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/creation_floating_button.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfit_piece/style_filter.dart';
import 'package:ooo_fit/widget/outfit_piece/wear_history_sort.dart';
import 'package:ooo_fit/widget/pieces/pieces_items_list.dart';
import 'package:ooo_fit/widget/pieces/placement_filter.dart';

class PiecesListPage extends StatefulWidget {
  const PiecesListPage({super.key});

  @override
  State<PiecesListPage> createState() => _PiecesListPageState();
}

class _PiecesListPageState extends State<PiecesListPage> {
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  PiecePlacement? placementFilter;
  late Style styleFilter;
  WearHistory? historySort;
  final double sortSeparator = 4.0;

  final Style allStylesOption =
      Style(id: "all", userId: '', name: "All", color: 0);

  @override
  void initState() {
    super.initState();
    styleFilter = allStylesOption;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width - (pageEdges + sortSeparator);
    double ratioWidth = screenWidth / 10;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My pieces',
        userMenu: true,
        weather_info: true,
      ),
      body: ContentFrameList(
        children: [
          Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStyleFilter(ratioWidth * 3),
                  _buildPlacementFilter(ratioWidth * 3),
                  SizedBox(width: sortSeparator),
                  _buildWearHistorySort(ratioWidth * 4),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          LoadingStreamBuilder<List<Piece>>(
            stream: _pieceService.getFilteredPiecesStream(
              styleFilter: styleFilter == allStylesOption ? null : styleFilter,
              placementFilter: placementFilter,
              historySort: historySort,
            ),
            builder: (context, piecesList) {
              return Flexible(
                child: PiecesItemsList(pieces: piecesList),
              );
            },
          ),
        ],
      ),
      floatingActionButton: CreationFloatingButton(page: PieceEditPage()),
      bottomNavigationBar:
          const CustomBottomNavigationBar(currentPage: PageTypes.pieces),
    );
  }

  Widget _buildStyleFilter(double width) {
    return StyleFilter(
      selectedStyle: styleFilter,
      allStylesOption: allStylesOption,
      onStyleChanged: (newStyle) {
        setState(() {
          styleFilter = newStyle;
        });
      },
      width: width,
    );
  }

  Widget _buildPlacementFilter(double width) {
    return PlacementFilter(
      selectedPlacement: placementFilter,
      onPlacementChanged: (PiecePlacement? newPlacement) {
        setState(() {
          placementFilter = newPlacement;
        });
      },
      width: width,
    );
  }

  Widget _buildWearHistorySort(double width) {
    return WearHistorySort(
      selectedHistorySort: historySort,
      onChanged: (newValue) {
        setState(() {
          historySort = newValue == "Default"
              ? null
              : WearHistory.values.firstWhere(
                  (sort) => sort.label == newValue,
                );
        });
      },
      width: width,
    );
  }
}
