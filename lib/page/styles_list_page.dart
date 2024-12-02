import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/styles/style_dialog.dart';
import 'package:ooo_fit/widget/styles/style_row.dart';

class StylesListPage extends StatelessWidget {
  final _styleService = GetIt.instance.get<StyleService>();

  StylesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Styles list"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            _buildStyleList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => StyleDialog(
                  style: null,
                )),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStyleList() {
    return Expanded(
      child: LoadingStreamBuilder(
        stream: _styleService.getAllStylesStream(),
        builder: (context, stylesList) {
          return ListView.separated(
            itemBuilder: (context, index) => StyleRow(style: stylesList[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: stylesList.length,
          );
        },
      ),
    );
  }
}
