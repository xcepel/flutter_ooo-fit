import 'package:flutter/material.dart';
import 'package:ooo_fit/page/events_list_page.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/page/pieces_list_page.dart';
import 'package:ooo_fit/page/styles_list_page.dart';
import 'package:ooo_fit/utils/page_types.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final PageTypes currentPage;

  const CustomBottomNavigationBar({super.key, required this.currentPage});

  void _navigate(BuildContext context, PageTypes page) {
    switch (page) {
      case PageTypes.outfits:
        _navigateToPage(context, OutfitsListPage());
        break;
      case PageTypes.pieces:
        _navigateToPage(context, PiecesListPage());
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
        barItem(Icons.accessibility_rounded, "My outfits", PageTypes.outfits),
        barItem(Icons.checkroom_rounded, "My pieces", PageTypes.pieces),
        barItem(Icons.calendar_month_rounded, "Calendar", PageTypes.events),
        barItem(Icons.auto_awesome_rounded, "My styles", PageTypes.styles),
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

  BottomBarItem barItem(IconData icon, String text, PageTypes page) {
    return BottomBarItem(
      icon: Icon(icon),
      title: Text(text),
      backgroundColor:
          currentPage == page ? Colors.deepPurpleAccent : Colors.grey,
    );
  }
}
