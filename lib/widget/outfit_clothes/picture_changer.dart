import 'package:flutter/material.dart';

class PictureChanger extends StatelessWidget {
  final String image;

  const PictureChanger({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth;
        return Stack(
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              // Grayscale picture
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: SizedBox(
                width: size,
                height: size,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO add action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
              child: const Text("Click to Change Picture"),
            ),
          ],
        );
      },
    );
  }
}
