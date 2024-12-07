import 'package:flutter/material.dart';
import 'package:ooo_fit/page/clothes_list_page.dart';
import 'package:ooo_fit/page/events_list_page.dart';
import 'package:ooo_fit/page/outfit_list_page.dart';
import 'package:ooo_fit/page/styles_list_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final PageTypes currentPage;

  const CustomBottomNavigationBar({super.key, required this.currentPage});

  void _navigate(BuildContext context, PageTypes page) {
    switch (page) {
      case PageTypes.outfits:
        _navigateToPage(context, OutfitListPage());
        break;
      case PageTypes.clothes:
        _navigateToPage(context, ClothesListPage());
        break;
      case PageTypes.events:
        _navigateToPage(context, EventsListPage());
        break;
      case PageTypes.styles:
        _navigateToPage(context, StylesListPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      option: AnimatedBarOptions(
        iconSize: 32,
        barAnimation: BarAnimation.fade,
        iconStyle: IconStyle.animated,
        opacity: 0.3,
      ),
      items: [
        BottomBarItem(
          icon: const Icon(Icons.accessibility_rounded),
          title: const Text("Outfits"),
          backgroundColor: currentPage == PageTypes.outfits
              ? Colors.deepPurple
              : Colors.grey,
        ),
        BottomBarItem(
          icon: const Icon(Icons.checkroom_rounded),
          title: const Text("Clothes"),
          backgroundColor: currentPage == PageTypes.clothes
              ? Colors.deepPurple
              : Colors.grey,
        ),
        BottomBarItem(
          icon: const Icon(Icons.calendar_month_rounded),
          title: const Text("Events"),
          backgroundColor:
              currentPage == PageTypes.events ? Colors.deepPurple : Colors.grey,
        ),
        BottomBarItem(
          icon: const Icon(Icons.auto_awesome_rounded),
          title: const Text("Styles"),
          backgroundColor:
              currentPage == PageTypes.styles ? Colors.deepPurple : Colors.grey,
        ),
      ],
      fabLocation: StylishBarFabLocation.center,
      hasNotch: true,
      currentIndex: currentPage.index,
      onTap: (int index) {
        final PageTypes page = PageTypes.values[index];
        _navigate(context, page);
      },
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
      (route) => false,
    );
  }
}
