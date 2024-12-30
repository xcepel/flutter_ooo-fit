import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';

class StylePicker extends StatelessWidget {
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  StylePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _styleService.getAllStylesStream(),
      builder: (context, styles) {
        return FormBuilderFilterChip(
          name: 'styleIds',
          decoration: const InputDecoration(labelText: 'Styles'),
          options: _getStyleChipOptions(styles),
        );
      },
    );
  }

  List<FormBuilderChipOption<String>> _getStyleChipOptions(List<Style> styles) {
    return styles
        .map((Style style) => FormBuilderChipOption(
              value: style.id,
              child: Text(style.name),
            ))
        .toList();
  }
}
