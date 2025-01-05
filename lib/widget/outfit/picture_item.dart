import 'package:flutter/material.dart';

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
              SizedBox.expand(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
