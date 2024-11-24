import 'package:flutter/material.dart';
import 'package:ooo_fit/page/clothes_list_page.dart';
import 'package:ooo_fit/page/outfit_list_page.dart';
import 'package:ooo_fit/page/styles_list_page.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';
import 'package:ooo_fit/widget/homepage/homepage_navigation_button.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "OOO-FIT"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO when have data - transfer into widgets
                    _buildStyledText(
                        "Your city", 30, FontWeight.bold, Colors.purple),
                    SizedBox(height: 10),
                    _buildStyledText("Po 13. December ♀ 13°C", 24,
                        FontWeight.w600, Colors.grey[700]!),
                    SizedBox(height: 40),
                    _buildStyledText(
                        "Planned events:", 24, FontWeight.bold, Colors.black87),
                    SizedBox(height: 10),
                    _buildStyledText("8:00 School " + " outfit1", 22,
                        FontWeight.normal, Colors.black54),
                    _buildStyledText("19:00 Cinema " + " KillerQueen", 22,
                        FontWeight.normal, Colors.black54),
                  ],
                ),
              ),
            ),
            // Buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomepageNavigationButton(
                    icon: Icons.accessibility_rounded,
                    label: "Outfits",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OutfitListPage()));
                    }),
                HomepageNavigationButton(
                    icon: Icons.checkroom_rounded,
                    label: "Clothes",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClothesListPage()));
                    }),
                HomepageNavigationButton(
                    icon: Icons.auto_awesome_rounded,
                    label: "Styles",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StylesListPage()));
                    }),
                HomepageNavigationButton(
                    icon: Icons.calendar_month_rounded,
                    label: "Events",
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledText(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize, // Font size
        fontWeight: fontWeight, // Font weight
        color: color, // Text color
      ),
      textAlign: TextAlign.center, // Optional: center-align text
    );
  }
}
