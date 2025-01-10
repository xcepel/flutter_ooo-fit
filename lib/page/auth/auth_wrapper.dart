import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/service/auth_service.dart';
import 'package:ooo_fit/widget/auth/sign_up_form.dart';

class AuthWrapper extends StatelessWidget {
  final AuthService _authService = GetIt.instance.get<AuthService>();

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStateChanges,
      builder: (context, userSnapshot) {
        if (userSnapshot.hasError) {
          return Text('Error');
        }

        if (!userSnapshot.hasData) {
          return SignUpForm();
        }

        return OutfitsListPage();
      },
    );
  }
}
