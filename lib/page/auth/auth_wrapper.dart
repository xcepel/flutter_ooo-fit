import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/auth/auth_page.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/service/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});
  final AuthService _authService = GetIt.instance.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return _authService.currentUser == null ? AuthPage() : OutfitsListPage();
  }
}
