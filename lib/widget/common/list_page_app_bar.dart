import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/auth/user_menu.dart';

import 'custom_app_bar.dart';

class ListPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ListPageAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      weather_info: true,
      lea: UserMenu(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
