import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/constants.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/styles/style_dot.dart';

class StylePicker extends StatelessWidget {
  final StyleService _styleService = GetIt.instance.get<StyleService>();
  final List<String>? selectedStyles;

  StylePicker({super.key, this.selectedStyles});

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _styleService.getAllStream(),
      builder: (context, styles) {
        return FormBuilderFilterChip(
          name: 'styleIds',
          spacing: chipSpacing,
          shape: chipShape,
          decoration: const InputDecoration(labelText: 'Styles'),
          initialValue: selectedStyles,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || (value.isEmpty)) {
              return 'Styles are required, pick at least one';
            }
            return null;
          },
          options: _getStyleChipOptions(styles),
        );
      },
    );
  }

  List<FormBuilderChipOption<String>> _getStyleChipOptions(List<Style> styles) {
    return styles
        .map((Style style) => FormBuilderChipOption(
              value: style.id,
              avatar: StyleDot(size: 15, color: style.color),
              child: Text(style.name),
            ))
        .toList();
  }
}
