import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/service/auth_service.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/auth/confirm_password_form_field.dart';
import 'package:ooo_fit/widget/auth/email_form_field.dart';
import 'package:ooo_fit/widget/auth/password_form_field.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthService _authService = GetIt.instance.get<AuthService>();

  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          EmailFormField(),
          const SizedBox(height: 10),
          PasswordFormField(
            showLengthInfo: _isSignUp,
          ),
          if (_isSignUp) ...[
            const SizedBox(height: 10),
            ConfirmPasswordFormField(formKey: _formKey),
          ],
          const SizedBox(height: 10),
          _buildSubmitButton(context),
          _buildFormSwitchButton(),
        ],
      ),
    );
  }

  TextButton _buildFormSwitchButton() {
    return TextButton(
      onPressed: () => setState(() => _isSignUp = !_isSignUp),
      child: Text(
        _isSignUp
            ? "Already have an account? Sign in"
            : "Don't have an account? Create one",
      ),
    );
  }

  LabelButton _buildSubmitButton(BuildContext context) {
    return LabelButton(
      label: _isSignUp ? 'Create Account' : 'Sign in',
      backgroundColor: Colors.transparent,
      textColor: Colors.deepPurple,
      onPressed: () =>
          _isSignUp ? _handleSignUp(context) : _handleSignIn(context),
    );
  }

  Future<void> _handleSignIn(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      String? error = await _authService.signInWithEmailAndPassword(
        email: formData['email'],
        password: formData['password'],
      );

      if (context.mounted) {
        handleActionResult(
          context: context,
          errorMessage: error,
          successMessage: 'Welcome',
          onSuccessNavigation: () => _navigateToHomePage(context),
        );
      }
    }
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      String? error = await _authService.createUserWithEmailAndPassword(
        email: formData['email'],
        password: formData['password'],
      );

      if (context.mounted) {
        handleActionResult(
          context: context,
          errorMessage: error,
          successMessage: 'Welcome',
          onSuccessNavigation: () => _navigateToHomePage(context),
        );
      }
    }
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OutfitsListPage()),
    );
  }
}
