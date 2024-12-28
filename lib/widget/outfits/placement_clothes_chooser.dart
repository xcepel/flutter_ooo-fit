import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/outfits/carousel.dart';

class PlacementClothesChooser extends StatefulWidget {
  final String label;
  final String icon;
  final List<String> clothesList;

  const PlacementClothesChooser({
    super.key,
    required this.label,
    required this.icon,
    required this.clothesList,
  });

  @override
  State<PlacementClothesChooser> createState() =>
      _PlacementClothesChooserState();
}

class _PlacementClothesChooserState extends State<PlacementClothesChooser> {
  final List<Widget> _carousels = [];

  @override
  void initState() {
    super.initState();
    _carousels.add(Carousel(pictureItemsData: widget.clothesList));
  }

  void _addCarousel() {
    setState(() {
      _carousels.add(Carousel(pictureItemsData: widget.clothesList));
    });
  }

  void _removeCarousel() {
    setState(() {
      if (_carousels.isNotEmpty) {
        _carousels.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        // Carousels
        ..._carousels,
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      width: double.infinity,
      color: Colors.deepPurpleAccent[100],
      child: Row(
        children: [
          Image.asset(
            widget.icon,
            color: Colors.black,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          DropdownFilter(label: "Style"),
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
              size: 20.0,
            ),
            onPressed: _addCarousel,
          ),
          IconButton(
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.black,
              size: 20.0,
            ),
            onPressed: _removeCarousel,
          ),
        ],
      ),
    );
  }
}
