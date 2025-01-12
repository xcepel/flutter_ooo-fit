import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/service/style_service.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_list.dart';
import 'package:ooo_fit/widget/common/creation_floating_button.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/styles/style_dialog.dart';
import 'package:ooo_fit/widget/styles/style_info_row.dart';

class StylesListPage extends StatelessWidget {
  final StyleService _styleService = GetIt.instance.get<StyleService>();

  StylesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My styles',
        userMenu: true,
        weather_info: true,
      ),
      body: ContentFrameList(
        children: [
          _buildStyleList(),
        ],
      ),
      floatingActionButton: CreationFloatingButton(
        onPressed: () {
          showCustomDialog(context);
        },
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentPage: PageTypes.styles),
    );
  }

  Widget _buildStyleList() {
    return Expanded(
      child: LoadingStreamBuilder(
        stream: _styleService.getAllStylesStream(),
        builder: (context, stylesList) {
          return ListView.separated(
            itemBuilder: (context, index) =>
                StyleInfoRow(style: stylesList[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: stylesList.length,
          );
        },
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => StyleDialog(
        style: null,
      ),
    );
  }
}
