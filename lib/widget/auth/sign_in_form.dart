import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/service/auth_service.dart';
import 'package:ooo_fit/widget/auth/email_form_field.dart';
import 'package:ooo_fit/widget/auth/password_form_field.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthService _authService = GetIt.instance.get<AuthService>();

  SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          EmailFormField(),
          const SizedBox(height: 10),
          PasswordFormField(),
          const SizedBox(height: 10),
          LabelButton(
            label: 'Sign in',
            backgroundColor: Colors.transparent,
            textColor: Colors.deepPurple,
            onPressed: () => _handleSignIn(),
          )
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final Map<String, dynamic> formData = _formKey.currentState!.value;
      await _authService.signInWithEmailAndPassword(
          email: formData['email'], password: formData['password']);
    }
  }
}
