import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/common/dropdown_filter.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/styles/style_dot.dart';

class StyleFilter extends StatelessWidget {
  final Style selectedStyle;
  final Style allStylesOption;
  final ValueChanged<Style> onStyleChanged;

  final StyleService _styleService = GetIt.instance.get<StyleService>();

  StyleFilter({
    required this.selectedStyle,
    required this.allStylesOption,
    required this.onStyleChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder<List<Style>>(
      stream: _styleService.getAllStylesStream(),
      builder: (context, styleList) {
        final List<Style> allStylesList = [allStylesOption, ...styleList];

        return DropdownFilter<String>(
          hint: "Style",
          value:
              selectedStyle.id == allStylesOption.id ? null : selectedStyle.id,
          items: allStylesList
              .map((style) => DropdownMenuItem<String>(
                    value: style.id,
                    child: Row(
                      children: [
                        StyleDot(size: 15, color: style.color),
                        SizedBox(width: 5),
                        Text(style.name),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            final Style selected = allStylesList.firstWhere(
              (style) => style.id == newValue,
              orElse: () => allStylesOption,
            );
            onStyleChanged(selected);
          },
        );
      },
    );
  }
}
