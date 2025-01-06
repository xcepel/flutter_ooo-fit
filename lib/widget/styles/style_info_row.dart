import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/styles/style_dialog.dart';
import 'package:ooo_fit/widget/styles/style_dot.dart';

class StyleInfoRow extends StatelessWidget {
  final Style style;
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  StyleInfoRow({super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StyleDot(size: 20, color: style.color),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              style.name,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_rounded),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => StyleDialog(
                        style: style,
                      ));
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.delete_rounded),
            onPressed: () => _styleService.delete(id: style.id),
          ),
        ],
      ),
    );
  }
}
