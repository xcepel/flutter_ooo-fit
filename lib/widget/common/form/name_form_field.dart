import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NameFormField extends StatelessWidget {
  const NameFormField({
    super.key,
    this.value,
    required this.isRequired,
  });

  final String? value;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'name',
      decoration: const InputDecoration(labelText: 'Name'),
      initialValue: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: isRequired
          ? FormBuilderValidators.required(errorText: 'Name is required')
          : null,
    );
  }
}
