import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(errorText: 'Password is required'),
          FormBuilderValidators.minLength(8,
              errorText: 'Please provide a password with minimal length of 8'),
        ],
      ),
    );
  }
}
