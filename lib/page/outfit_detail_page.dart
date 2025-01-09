import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/model/outfit.dart';
import 'package:ooo_fit/model/piece.dart';
import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/page/outfit_edit_page.dart';
import 'package:ooo_fit/service/outfit_service.dart';
import 'package:ooo_fit/utils/date_time_formater.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/common/custom_bottom_navigation_bar.dart';
import 'package:ooo_fit/widget/common/edit_button.dart';
import 'package:ooo_fit/widget/common/info_bubble.dart';
import 'package:ooo_fit/widget/common/loading_stream_builder.dart';
import 'package:ooo_fit/widget/common/page_divider.dart';
import 'package:ooo_fit/widget/outfit_piece/description_label.dart';
import 'package:ooo_fit/widget/outfit_piece/sized_picture.dart';
import 'package:ooo_fit/widget/outfits/wear_now_button.dart';
import 'package:ooo_fit/widget/pieces/pieces_items_list.dart';
import 'package:ooo_fit/widget/styles/style_data_row.dart';

class OutfitDetailPage extends StatelessWidget {
  final String outfitId;
  final OutfitService _outfitService = GetIt.instance.get<OutfitService>();

  OutfitDetailPage({
    super.key,
    required this.outfitId,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingStreamBuilder(
      stream: _outfitService.getOutfitDetailByIdStream(outfitId),
      builder: (context, outfitData) {
        final Outfit outfit = outfitData.$1!;
        final Map<String, Style> styles = outfitData.$2;
        final Map<String, Piece> pieces = outfitData.$3;

        return Scaffold(
          appBar: CustomAppBar(
            title: outfit.name ?? "",
            actionButton: EditButton(
              editPage: OutfitEditPage(
                outfit: outfit,
              ),
            ),
          ),
          body: ContentFrameDetail(
            children: [
              StyleDataRow(items: styles.values.toList()),
              const SizedBox(height: 10),
              Row(
                children: [
                  outfit.temperature.icon,
                  Text(outfit.temperature.label),
                ],
              ),
              const SizedBox(height: 10),
              DescriptionLabel(
                label: "Last worn",
                value: outfit.lastWorn != null
                    ? DateTimeFormatter(outfit.lastWorn!).formatDate()
                    : "---",
              ),
              const SizedBox(height: 10),
              WearNowButton(outfitId: outfitId),
              const SizedBox(height: 10),
              _buildOutfitImageSection(outfit.imagePath),
              const PageDivider(),
              const SizedBox(height: 5),
              PiecesItemsList(pieces: pieces.values.toList()),
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigationBar(currentPage: PageTypes.outfits),
        );
      },
    );
  }

  Widget _buildOutfitImageSection(String? imagePath) {
    return imagePath != null
        ? _buildOutfitImage(imagePath)
        : InfoBubble(
            message:
                "You haven't taken a picture of your outfit yet. Do it now!",
          );
  }

  Widget _buildOutfitImage(String? outfitPicture) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth;
        return SizedPicture(
          sizeX: size,
          sizeY: size * 1.3,
          image: outfitPicture ?? '',
        );
      },
    );
  }
}
