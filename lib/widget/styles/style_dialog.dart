import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import the color picker package

class StyleDialog extends StatefulWidget {
  final Style? style;
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  StyleDialog({super.key, required this.style});

  @override
  State<StyleDialog> createState() => _StyleDialogState();
}

class _StyleDialogState extends State<StyleDialog> {
  final TextEditingController _styleNameController = TextEditingController();
  Color _chosenColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _styleNameController.text = widget.style?.name ?? '';
    _chosenColor =
        widget.style != null ? Color(widget.style!.color) : Colors.white;
  }

  @override
  void didUpdateWidget(StyleDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.style != widget.style) {
      _styleNameController.text = widget.style?.name ?? '';
      _chosenColor =
          widget.style != null ? Color(widget.style!.color) : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Style"),
      insetPadding: EdgeInsets.all(10),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildNameFormField(),
              _buildColorPicker(),
              _buildFormButtons(context),
            ],
          ),
        )
      ],
    );
  }

  TextFormField _buildNameFormField() {
    return TextFormField(
      controller: _styleNameController,
      decoration: InputDecoration(
        labelText: 'Name',
      ),
    );
  }

  Widget _buildColorPicker() {
    return Column(
      children: [
        Text("Select Color", style: TextStyle(fontSize: 16)),
        ColorPicker(
          pickerColor: _chosenColor,
          enableAlpha: false,
          labelTypes: [],
          onColorChanged: (Color color) {
            setState(() {
              _chosenColor = color;
            });
          },
          pickerAreaHeightPercent: 0.5,
        ),
      ],
    );
  }

  Row _buildFormButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            String newName = _styleNameController.text;
            if (widget.style == null) {
              widget._styleService.saveStyle(
                name: newName,
                color: _chosenColor.value,
              );
            } else {
              widget._styleService.updateStyle(
                style: widget.style!,
                name: newName,
                color: _chosenColor.value,
              );
            }

            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
