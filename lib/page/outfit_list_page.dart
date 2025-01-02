import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/custom_floating_action_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfit_piece/three_part_filter_bar.dart';
import 'package:ooo_fit/widget/outfits/outfit_items_list.dart';

class OutfitListPage extends StatelessWidget {
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();
  // TODO kvuli filtrovani to asi necham tady?

  OutfitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Outfit list", weather_info: true),
      body: ContentFrameList(
        children: [
          ThreePartFilterBar(
            filter1Name: "Style",
            filter2Name: "Weather",
            filter3Name: "Wear History",
          ),
          LoadingStreamBuilder<
              (List<Outfit>, Map<String, Style>, Map<String, Piece>)>(
            stream: _outfitService.getOutfitsWithStylesAndPiecesStream(),
            builder: (context, data) {
              return Expanded(
                child: OutfitItemsList(
                  outfits: data.$1,
                  styles: data.$2,
                  pieces: data.$3,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OutfitEditPage()));
        },
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.outfits),
    );
  }
}
