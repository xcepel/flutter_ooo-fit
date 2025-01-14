import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/auth/user_menu.dart';
import 'package:ooo_fit/widget/weather/weather_info.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool weather_info;
  final Widget? rightActionButton;
  final bool userMenu;

  const CustomAppBar({
    super.key,
    this.title,
    this.weather_info = false,
    this.rightActionButton,
    this.userMenu = false,
  }) : assert(!(rightActionButton != null && weather_info == true),
            'rightActionButton and weather_info cannot both be set at the same time');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.deepPurpleAccent,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: Colors.white),
            )
          : null,
      leading: userMenu ? UserMenu() : null,
      actions: [
        if (weather_info)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: WeatherInfo(),
          ),
        if (rightActionButton != null) rightActionButton!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
