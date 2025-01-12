import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/piece_edit_page.dart';
import 'package:ooo_fit/service/piece_service.dart';
import 'package:ooo_fit/utils/date_time_formater.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_piece/description_label.dart';
import 'package:ooo_fit/widget/outfit_piece/list_item.dart';
import 'package:ooo_fit/widget/outfit_piece/sized_picture.dart';
import 'package:ooo_fit/widget/styles/style_data_row.dart';

class PieceDetailPage extends StatelessWidget {
  final String pieceId;
  final PieceService _pieceService = GetIt.instance.get<PieceService>();

  PieceDetailPage({
    super.key,
    required this.pieceId,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _pieceService.getPieceDetailByIdStream(pieceId),
      builder: (context, pieceData) {
        return Scaffold(
          appBar: CustomAppBar(
            title: pieceData.$1!.name,
            rightActionButton: EditButton(
                editPage: PieceEditPage(
              piece: pieceData.$1,
            )),
          ),
          body: ContentFrameDetail(
            children: [
              StyleDataRow(items: pieceData.$2.values.toList()),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    pieceData.$1!.piecePlacement.picture,
                    color: Colors.black,
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  Text(pieceData.$1!.piecePlacement.label)
                ],
              ),
              SizedBox(height: 10),
              DescriptionLabel(
                label: "Last worn",
                value: pieceData.$1!.lastWorn != null
                    ? DateTimeFormatter(pieceData.$1!.lastWorn!).formatDate()
                    : "---",
              ),
              SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  double size = constraints.maxWidth;
                  return SizedPicture(
                    sizeX: size,
                    sizeY: size,
                    image: pieceData.$1!.imagePath,
                  );
                },
              ),
              PageDivider(),
              // TODO nevim jak to tahat. budeme to vubec ukazovat, nebo to nenapadne zahrabeme?
              DescriptionLabel(label: "In outfits", value: ""),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListItem(text: "outfit$index");
                },
              ),
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigationBar(currentPage: PageTypes.pieces),
        );
      },
    );
  }
}
