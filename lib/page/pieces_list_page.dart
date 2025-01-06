import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/piece_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/pieces/pieces_items_list.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/creation_floating_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/styles/style_dot.dart';

class PiecesListPage extends StatefulWidget {
  const PiecesListPage({super.key});

  @override
  State<PiecesListPage> createState() => _PiecesListPageState();
}

class _PiecesListPageState extends State<PiecesListPage> {
  final PieceService _pieceService = GetIt.instance.get<PieceService>();
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  String? placementFilter;

  final Style allStylesOption = Style(id: "all", name: "All", color: 0);
  late Style testStyleFilter;

  @override
  void initState() {
    super.initState();
    testStyleFilter = allStylesOption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pieces list", weather_info: true),
      body: ContentFrameList(
        children: [
          Row(
            children: [
              LoadingStreamBuilder<List<Style>>(
                  stream: _styleService.getAllStylesStream(),
                  builder: (context, styleList) {
                    final allStylesList = [allStylesOption, ...styleList];

                    return DropdownButton<String>(
                      hint: Text("Style"),
                      value: testStyleFilter.id == allStylesOption.id
                          ? null
                          : testStyleFilter.id,
                      items: allStylesList.map((style) {
                        return DropdownMenuItem<String>(
                          value: style.id,
                          child: Row(
                            children: [
                              StyleDot(size: 15, color: style.color),
                              SizedBox(width: 5),
                              Text(style.name)
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          testStyleFilter = allStylesList.firstWhere(
                              (style) => style.id == newValue,
                              orElse: () => allStylesOption);
                        });
                      },
                    );
                  }),
              DropdownFilter(
                label: "Placement",
                value: placementFilter,
                data: PiecePlacement.values
                    .map((placement) => placement.label)
                    .toList(),
                onChanged: (String? newFilter) {
                  setState(() {
                    placementFilter = newFilter;
                  });
                },
              ),
            ],
          ),
          LoadingStreamBuilder<List<Piece>>(
            stream: _pieceService.getFilteredPiecesStream(
                styleFilter:
                    testStyleFilter == allStylesOption ? null : testStyleFilter,
                placementFilter: placementFilter),
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
