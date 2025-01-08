import 'package:flutter/material.dart';
import 'package:ooo_fit/service/util/image_functions.dart';
import 'package:ooo_fit/widget/common/loading_future_builder.dart';

class DownloadedImage extends StatelessWidget {
  const DownloadedImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return LoadingFutureBuilder<String?>(
        future: getImageDownloadURL(imagePath),
        builder: (context, downloadUrl) {
          return Image.network(
            downloadUrl!,
            fit: BoxFit.cover,
          );
        });
  }
}
