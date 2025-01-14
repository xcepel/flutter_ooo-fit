import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ooo_fit/page/outfits_list_page.dart';
import 'package:ooo_fit/service/auth_service.dart';
import 'package:ooo_fit/service/user_data_service.dart';
import 'package:ooo_fit/utils/functions.dart';
import 'package:ooo_fit/widget/auth/confirm_password_form_field.dart';
import 'package:ooo_fit/widget/auth/email_form_field.dart';
import 'package:ooo_fit/widget/auth/password_form_field.dart';
import 'package:ooo_fit/widget/outfit_piece/label_button.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthService _authService = GetIt.instance.get<AuthService>();
  final UserDataService _userDataService =
      GetIt.instance.get<UserDataService>();

  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          EmailFormField(),
          if (_isSignUp) ...[
            SizedBox(
              height: 10,
            ),
            _buildCityTextField(),
          ],
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

  FormBuilderTextField _buildCityTextField() {
    return FormBuilderTextField(
      name: 'city',
      decoration: InputDecoration(
          labelText: 'City',
          helperText:
              'This detail will be used to fetch you the current weather info in you area. You can change it later in the user details.',
          helperMaxLines: 3),
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

      String? userId = _authService.currentUser!.uid;

      await _userDataService.saveUserData(
        userId: userId,
        city: formData['city'],
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
