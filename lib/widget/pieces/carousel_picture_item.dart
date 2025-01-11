import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/downloaded_image.dart';

class CarouselPictureItem extends StatelessWidget {
  final String image;

  const CarouselPictureItem({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: 100.0,
          height: 100.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: DownloadedImage(imagePath: image),
          ),
        );
      },
    );
  }
}
