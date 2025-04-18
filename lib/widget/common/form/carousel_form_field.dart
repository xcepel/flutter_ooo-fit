import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ooo_fit/widget/common/form/carousel.dart';
import 'package:ooo_fit/widget/common/form/carousel_header.dart';

class CarouselFormField extends StatefulWidget {
  final Widget? leading;
  final List<CarouselItem> items;
  final List<String>? selectedIds;
  final bool multipleSelection;
  final String name;
  final bool forEventOutfit;

  const CarouselFormField({
    super.key,
    this.leading,
    required this.items,
    this.selectedIds,
    required this.multipleSelection,
    required this.name,
    this.forEventOutfit = false,
  });

  @override
  State<CarouselFormField> createState() => _CarouselFormFieldState();
}

class _CarouselFormFieldState extends State<CarouselFormField> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();

    // the user sees the form for the first time, they are shown one carousel
    if (widget.selectedIds == null) {
      _selectedIds = widget.items.isEmpty ? [] : [widget.items[0].id];
      // the user wants to see their empty selection, they are shown 0 carousels
    } else if (widget.selectedIds!.isEmpty) {
      _selectedIds = [];
      // n carousels with the selected items
    } else {
      _selectedIds = widget.selectedIds!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>?>(
      name: widget.name,
      initialValue: List.from(_selectedIds),
      builder: (FormFieldState<List<String>?> field) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
          ),
          child: Column(
            children: [
              _buildHeader(field),
              if (widget.items.isNotEmpty)
                ..._buildCarousels(field)
              else
                Text(
                  'No items available',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != null && value.toSet().length != value.length) {
          return 'You cannot pick the same item twice.';
        }
        return null;
      },
    );
  }

  Widget _buildHeader(FormFieldState<List<String>?> field) {
    return CarouselHeader(
      leading: widget.leading,
      multipleSelection: widget.multipleSelection,
      onAddCarousel: () => _addCarousel(field),
      onRemoveCarousel: () => _removeCarousel(field),
    );
  }

  void _addCarousel(FormFieldState<List<String>?> field) {
    setState(() {
      _selectedIds.add(widget.items[0].id);
    });
    _updateFormFieldState(field);
  }

  void _removeCarousel(FormFieldState<List<String>?> field) {
    setState(() {
      if (_selectedIds.isNotEmpty) {
        _selectedIds.removeLast();
      }
    });
    _updateFormFieldState(field);
  }

  List<Widget> _buildCarousels(FormFieldState<List<String>?> field) {
    return List.generate(
      _selectedIds.length,
      (index) => Carousel(
        items: widget.items,
        onChanged: (String value) => _handleChange(field, index, value),
        selectedId: _selectedIds[index],
        forEventOutfit: widget.forEventOutfit,
      ),
    );
  }

  void _handleChange(
    FormFieldState<List<String>?> field,
    int index,
    String value,
  ) {
    setState(() {
      _selectedIds[index] = value;
    });

    _updateFormFieldState(field);
  }

  void _updateFormFieldState(FormFieldState<List<String>?> field) {
    final nonEmptyIds = _selectedIds.where((id) => id.isNotEmpty).toList();
    field.didChange(List.from(nonEmptyIds));
  }
}
