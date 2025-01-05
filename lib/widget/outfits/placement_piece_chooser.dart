import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/common/form/carousel.dart';
import 'package:ooo_fit/model/piece_placement.dart';

class PlacementPieceChooser extends StatefulWidget {
  final PiecePlacement piecePlacement;
  final List<Piece> piecesList;
  final List<String>? selectedIds;

  const PlacementPieceChooser({
    super.key,
    required this.piecePlacement,
    required this.piecesList,
    this.selectedIds,
  });

  @override
  State<PlacementPieceChooser> createState() => _PlacementPieceChooserState();
}

class _PlacementPieceChooserState extends State<PlacementPieceChooser> {
  late List<String> _selectedIds = [];
  // final List<Widget> _carousels = [];

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.selectedIds ?? [''];
  }

  void _addCarousel() {
    setState(() {
      _selectedIds.add('');
    });
  }

  void _removeCarousel() {
    setState(() {
      if (_selectedIds.isNotEmpty) {
        _selectedIds.removeLast();
      }
    });
  }

  List<Widget> _buildCarousels(FormFieldState<List<String>?> field) {
    return List.generate(
      _selectedIds.length,
      (index) => Carousel(
        itemList: widget.piecesList
            .map((Piece piece) => CarouselItem(
                  id: piece.id,
                  imagePath: piece.imagePath,
                ))
            .toList(),
        onChanged: (value) => _handleChange(field, index, value),
        initialSelectedId: _selectedIds[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>?>(
      name: 'carousel_${widget.piecePlacement.name}',
      initialValue: _selectedIds,
      onChanged: (List<String>? val) => print(val.toString()),
      builder: (FormFieldState<List<String>?> field) {
        return Column(
          children: [
            _buildHeader(),
            if (widget.piecesList.isNotEmpty)
              ..._buildCarousels(field)
            else
              Text('No items available'),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _handleChange(
      FormFieldState<List<String>?> field, int index, String value) {
    setState(() {
      if (index < _selectedIds.length) {
        _selectedIds[index] = value;
      } else {
        _selectedIds.add(value);
      }
    });

    //TODO: move checking elsewhere maybe
    final nonEmptyIds = _selectedIds.where((id) => id.isNotEmpty).toList();
    field.didChange(List.from(nonEmptyIds));
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      width: double.infinity,
      color: Colors.deepPurpleAccent[100],
      child: Row(
        children: [
          Image.asset(
            widget.piecePlacement.picture,
            color: Colors.black,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(
            widget.piecePlacement.name,
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
