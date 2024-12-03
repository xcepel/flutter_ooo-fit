import 'package:flutter/material.dart';
import 'package:ooo_fit/constants.dart';
import 'package:ooo_fit/page/clothes_edit_page.dart';
import 'package:ooo_fit/widget/clothes/clothes_items_list.dart';
import 'package:ooo_fit/widget/clothes/placement_header.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/outfit_clothes/four_part_filter_bar.dart';

class ClothesListPage extends StatelessWidget {
  const ClothesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Clothes list"),
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            FourPartFilterBar(
              filter1: "Style",
              filter2: "Placement",
              filter3: "Sort by",
            ),
            // List of clothes
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlacementHeader(label: "Placement $index"),
                      ClothesItemsList(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ClothesEditPage()));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
