import 'package:flutter/material.dart';

class PictureItem extends StatelessWidget {
  final String image;
  final String title;
  final String style;
  final String lastWorn;

  const PictureItem({
    super.key,
    required this.image,
    required this.title,
    required this.style,
    required this.lastWorn,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Picture
          LayoutBuilder(
            builder: (context, constraints) {
              double imageHeight = constraints.maxWidth * 1.25;
              return Stack(
                children: [
                  // Image
                  SizedBox(
                    width: double.infinity,
                    height: imageHeight,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Floating button positioned at bottom-right
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      child: Icon(Icons.favorite_border_rounded),
                    ),
                  ),
                ],
              );
            },
          ),
          // Details (text)
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3.0),
                // Description (max 2 lines)
                Text(
                  style,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                // Date (Last Worn)
                Text(
                  lastWorn,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
