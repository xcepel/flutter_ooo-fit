import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit_clothes/picture_item.dart';

class Carousel extends StatefulWidget {
  final List<String> pictureItemsData;

  const Carousel({super.key, required this.pictureItemsData});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.pictureItemsData.length,
      itemBuilder: (context, index, realIndex) {
        // Determine if the current item is the focused one
        final bool isFocused = index == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: EdgeInsets.symmetric(horizontal: isFocused ? 4.0 : 0),
          decoration: BoxDecoration(
            color: isFocused ? Colors.deepPurpleAccent : null,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: PictureItem(
            image: widget.pictureItemsData[index],
            // TODO Non-active gray coloring for unfocused items?
          ),
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 3 / 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        viewportFraction: 0.3,
        initialPage: _currentIndex,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            _currentIndex = index;
          });
        },
        scrollPhysics: PageScrollPhysics(),
      ),
    );
  }
}
