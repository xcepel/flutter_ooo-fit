import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/outfits/carousel.dart';
import 'package:ooo_fit/model/piece_placement.dart';

class PlacementPieceChooser extends StatefulWidget {
  final PiecePlacement details;
  final List<String> piecesList;

  const PlacementPieceChooser({
    super.key,
    required this.details,
    required this.piecesList,
  });

  @override
  State<PlacementPieceChooser> createState() => _PlacementPieceChooserState();
}

class _PlacementPieceChooserState extends State<PlacementPieceChooser> {
  final List<Widget> _carousels = [];

  @override
  void initState() {
    super.initState();
    _carousels.add(Carousel(pictureItemsData: widget.piecesList));
  }

  void _addCarousel() {
    setState(() {
      _carousels.add(Carousel(pictureItemsData: widget.piecesList));
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
            widget.details.picture,
            color: Colors.black,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(
            widget.details.name,
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
