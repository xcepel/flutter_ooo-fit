import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/weather/weather_info.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool weather_info;
  final Widget? actionButton;

  const CustomAppBar({
    super.key,
    this.title,
    this.weather_info = false,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.deepPurpleAccent,
      centerTitle: true,
      leading: weather_info
          ? SizedBox(
              width: 56,
              child: WeatherInfo(),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: Colors.white),
            )
          : null,
      actions: [
        if (actionButton != null) actionButton!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
