import 'package:flutter/material.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/custom_floating_action_button.dart';
import 'package:ooo_fit/widget/outfit_clothes/three_part_filter_bar.dart';
import 'package:ooo_fit/widget/outfits/outfit_items_list.dart';

class OutfitListPage extends StatelessWidget {
  const OutfitListPage({super.key});

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
          OutfitItemsList(),
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
