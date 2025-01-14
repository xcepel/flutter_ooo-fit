import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/auth_page.dart';
import 'package:ooo_fit/page/user_details_page.dart';
import 'package:ooo_fit/service/auth_service.dart';

class UserMenu extends StatelessWidget {
  final AuthService _authService = GetIt.instance.get<AuthService>();

  UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.person_rounded, color: Colors.white),
      onSelected: (value) => _handleMenuSelection(value, context),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('My details'),
          ),
        ),
        PopupMenuItem(
          value: 'sign_out',
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
          ),
        ),
      ],
    );
  }

  void _handleMenuSelection(String value, BuildContext context) async {
    if (value == 'profile') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsPage(),
        ),
      );
    } else if (value == 'sign_out') {
      await _authService.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
        (route) => false,
      );
    }
  }
}
