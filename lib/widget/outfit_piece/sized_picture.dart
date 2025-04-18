import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/common/downloaded_image.dart';

// TODO probably change so it does not fill the whole page
class SizedPicture extends StatelessWidget {
  final double sizeX;
  final double sizeY;
  final String image;

  const SizedPicture(
      {super.key,
      required this.sizeX,
      required this.sizeY,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: SizedBox(
        width: sizeX,
        height: sizeY,
        child: DownloadedImage(imagePath: image),
      ),
    );
  }
}
