import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/clothes/clothes_items_list.dart';
import 'package:ooo_fit/widget/clothes/placement_header.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/outfit_clothes/four_part_filter_bar.dart';

class ClothesListPage extends StatelessWidget {
  const ClothesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Clothes list"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
