import 'package:flutter/material.dart';
import 'package:ooo_fit/widget/auth/auth_form.dart';
import 'package:ooo_fit/widget/common/content_frame_detail.dart';
import 'package:ooo_fit/widget/common/custom_app_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Welcome'),
      body: ContentFrameDetail(
        children: [AuthForm()],
      ),
    );
  }
}
