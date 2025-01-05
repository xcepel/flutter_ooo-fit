import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/outfit/picture_item.dart';

class CarouselItem {
  final String id;
  final String imagePath;

  CarouselItem({
    required this.id,
    required this.imagePath,
  });
}

class Carousel extends StatefulWidget {
  final List<CarouselItem> itemList;
  final void Function(String) onChanged;
  final String? initialSelectedId;

  const Carousel({
    super.key,
    required this.itemList,
    required this.onChanged,
    this.initialSelectedId,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialSelectedId != null
        ? widget.itemList
            .indexWhere((value) => value.id == widget.initialSelectedId)
        : 0;

    if (_currentIndex == -1) {
      _currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemList.isEmpty) {
      return Center(child: Text("No items available"));
    }

    return CarouselSlider.builder(
      itemCount: widget.itemList.length,
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
            image: widget.itemList[index].imagePath,
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
          widget.onChanged(widget.itemList[index].id);
        },
        scrollPhysics: PageScrollPhysics(),
      ),
    );
  }
}
