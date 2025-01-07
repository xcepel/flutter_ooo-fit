import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/weather/weather_info.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool weather_info;
  final Widget? actionButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.weather_info = false,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurpleAccent,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        if (weather_info)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: WeatherInfo(),
          ),
        if (actionButton != null) actionButton!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
