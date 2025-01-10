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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon:
            (_formKey.currentState?.fields['confirm_password']?.hasError ??
                    false)
                ? const Icon(Icons.error, color: Colors.red)
                : const Icon(Icons.check, color: Colors.green),
      ),
      obscureText: true,
      validator: (value) =>
          _formKey.currentState?.fields['password']?.value != value
              ? 'Passwords are not the same'
              : null,
    );
  }
}
