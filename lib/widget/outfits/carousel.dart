import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_item.dart';

class Carousel extends StatelessWidget {
  final List<Map<String, String>> pictureItemsData;

  const Carousel({super.key, required this.pictureItemsData});

  // TODO the chosen one/s should be displayed differently
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: pictureItemsData.length,
      itemBuilder: (context, index, realIndex) {
        final data = pictureItemsData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: 200, // Increased width here
            child: PictureItem(
              image: data['image']!,
              title: data['title']!,
              style: data['style']!,
              lastWorn: data['lastWorn']!,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 270.0,
        enlargeCenterPage: false,
        autoPlay: false,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.3,
        initialPage: 1, // TODO show the chosen clothing item by index
      ),
    );
  }
}
