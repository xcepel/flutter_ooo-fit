import 'package:flutter/material.dart';
import 'package:ooo_fit/model/piece_placement.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/model/temperature_type.dart';
import 'package:ooo_fit/widget/outfit_piece/bottom_data.dart';
import 'package:ooo_fit/widget/outfit_piece/top_warning_data.dart';

class ListItemCard extends StatelessWidget {
  final String? name;
  final List<Style> styles;
  final TemperatureType? temperature;
  final PiecePlacement? piecePlacement;
  final bool topWarning;
  final Widget image;
  const ListItemCard({
    super.key,
    this.name,
    required this.styles,
    this.temperature,
    this.piecePlacement,
    required this.topWarning,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              image,
              topWarning ? TopWarningData() : SizedBox(),
              BottomData(
                styles: styles,
                temperature: temperature,
                placement: piecePlacement,
              ),
            ],
          ),
          if (name != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Text(name!),
            ),
        ],
      ),
    );
  }
}
