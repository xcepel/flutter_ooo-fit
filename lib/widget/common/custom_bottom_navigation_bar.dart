import 'package:flutter/material.dart';
import 'package:ooo_fit/page/clothes_list_page.dart';
import 'package:ooo_fit/page/events_list_page.dart';
import 'package:ooo_fit/page/homepage.dart';
import 'package:ooo_fit/page/outfit_list_page.dart';
import 'package:ooo_fit/page/styles_list_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        _navigateToPage(context, Homepage());
        break;
      case 1:
        _navigateToPage(context, OutfitListPage());
        break;
      case 2:
        _navigateToPage(context, ClothesListPage());
        break;
      case 3:
        _navigateToPage(context, StylesListPage());
        break;
      case 4:
        _navigateToPage(context, EventsListPage());
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
          icon: const Icon(Icons.home_rounded),
          title: const Text("Home"),
          backgroundColor: Colors.deepPurple,
        ),
        BottomBarItem(
          icon: const Icon(Icons.accessibility_rounded),
          title: const Text("Outfits"),
          backgroundColor: Colors.deepPurple,
        ),
        BottomBarItem(
          icon: const Icon(Icons.checkroom_rounded),
          title: const Text("Clothes"),
          backgroundColor: Colors.deepPurple,
        ),
        BottomBarItem(
          icon: const Icon(Icons.auto_awesome_rounded),
          title: const Text("Styles"),
          backgroundColor: Colors.deepPurple,
        ),
        BottomBarItem(
          icon: const Icon(Icons.calendar_month_rounded),
          title: const Text("Events"),
          backgroundColor: Colors.deepPurple,
        ),
      ],
      fabLocation: StylishBarFabLocation.center,
      hasNotch: true,
      currentIndex: currentIndex,
      onTap: (index) => _navigate(context, index),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false, // removes all previous routes from the stack
    );
  }
}
