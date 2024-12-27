import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/bottom_style_dots.dart';

class PictureItem extends StatelessWidget {
  final String image;

  const PictureItem({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          child: Stack(
            children: [
              // Image
              SizedBox.expand(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              BottomStyleDots(
                styleColors: [Colors.deepPurple, Colors.pinkAccent],
              ),
            ],
          ),
        );
      },
    );
  }
}
