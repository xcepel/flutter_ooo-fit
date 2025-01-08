import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselItem {
  final String id;
  final Widget child;

  CarouselItem({
    required this.id,
    required this.child,
  });
}

class Carousel extends StatefulWidget {
  final List<CarouselItem> items;
  final void Function(String) onChanged;
  final String? selectedId;
  final bool forEventOutfit;

  const Carousel({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedId,
    this.forEventOutfit = false,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.selectedId != null
        ? widget.items.indexWhere((value) => value.id == widget.selectedId)
        : 0;

    if (_currentIndex == -1) {
      _currentIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Center(child: Text("No items available"));
    }

    return CarouselSlider.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index, realIndex) {
        // Determine if the current item is the focused one
        final bool isFocused = index == _currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: EdgeInsets.symmetric(horizontal: isFocused ? 4.0 : 0),
          decoration: BoxDecoration(
            color: isFocused ? Colors.deepPurpleAccent[100] : null,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: widget.items[index].child,
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: widget.forEventOutfit ? false : true,
        autoPlay: false,
        aspectRatio: widget.forEventOutfit ? 1.39 / 1 : 3 / 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: false,
        viewportFraction: widget.forEventOutfit ? 0.4 : 0.3,
        initialPage: _currentIndex,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            _currentIndex = index;
          });
          widget.onChanged(widget.items[index].id);
        },
        scrollPhysics: PageScrollPhysics(),
      ),
    );
  }
}
