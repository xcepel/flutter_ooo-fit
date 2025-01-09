import 'package:flutter/material.dart';
import 'package:ooo_fit/service/util/image_functions.dart';

class DownloadedImage extends StatelessWidget {
  const DownloadedImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getImageDownloadURL(imagePath),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Image.asset(
            'assets/images/image_error.png',
            fit: BoxFit.cover,
          );
        }

        if (!snapshot.hasData) {
          return Image.asset(
            'assets/images/light_gray_solid.jpg',
            fit: BoxFit.cover,
          );
        }

        String downloadUrl = snapshot.data!;
        return Image.network(
          downloadUrl,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
