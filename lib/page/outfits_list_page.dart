import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/model/wear_history.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/creation_floating_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/outfit_piece/style_filter.dart';
import 'package:ooo_fit/widget/outfit_piece/wear_history_sort.dart';
import 'package:ooo_fit/widget/outfits/outfit_items_list.dart';
import 'package:ooo_fit/widget/outfits/temperature_filter.dart';

class OutfitsListPage extends StatefulWidget {
  const OutfitsListPage({super.key});

  @override
  State<OutfitsListPage> createState() => _OutfitsListPageState();
}

class _OutfitsListPageState extends State<OutfitsListPage> {
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();

  late Style styleFilter;
  TemperatureType? temperatureFilter;
  WearHistory? historySort;

  final Style allStylesOption = Style(id: "all", name: "All", color: 0);

  @override
  void initState() {
    super.initState();
    styleFilter = allStylesOption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Outfit list", weather_info: true),
      body: ContentFrameList(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStyleFilter(),
              SizedBox(width: 4),
              _buildTemperatureFilter(),
              SizedBox(width: 12),
              _buildWearHistorySort(),
            ],
          ),
          SizedBox(height: 10),
          LoadingStreamBuilder<
              (List<Outfit>, Map<String, Style>, Map<String, Piece>)>(
            stream: _outfitService.getFilteredOutfitsWithStylesAndPiecesStream(
                styleFilter:
                    styleFilter == allStylesOption ? null : styleFilter,
                temperatureFilter: temperatureFilter,
                historySort: historySort),
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
      floatingActionButton: CreationFloatingButton(page: OutfitEditPage()),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.outfits),
    );
  }

  Widget _buildStyleFilter() {
    return StyleFilter(
      selectedStyle: styleFilter,
      allStylesOption: allStylesOption,
      onStyleChanged: (newStyle) {
        setState(() {
          styleFilter = newStyle;
        });
      },
    );
  }

  Widget _buildTemperatureFilter() {
    return TemperatureFilter(
      selectedTemperature: temperatureFilter,
      onTemperatureChanged: (newTemperature) {
        setState(() {
          temperatureFilter = newTemperature;
        });
      },
    );
  }

  Widget _buildWearHistorySort() {
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
    );
  }
}
