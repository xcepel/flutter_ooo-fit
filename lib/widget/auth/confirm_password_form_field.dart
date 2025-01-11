import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  const ConfirmPasswordFormField({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'confirm_password',
      decoration: InputDecoration(
        labelText: 'Confirm Password',
      ),
      obscureText: true,
      validator: (value) =>
          _formKey.currentState?.fields['password']?.value != value
              ? 'Passwords do not match'
              : null,
    );
  }
}
