import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_item.dart';

class Carousel extends StatelessWidget {
  final List<Map<String, String>> pictureItemsData;

  // Constructor to accept a list of data for PictureItems
  const Carousel({super.key, required this.pictureItemsData});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: pictureItemsData.length,
      itemBuilder: (context, index, realIndex) {
        final data = pictureItemsData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: 150,
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
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.25,
      ),
    );
  }
}
