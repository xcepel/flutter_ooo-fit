import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ooo_fit/model/user_data.dart';

class UserDetailsForm extends StatelessWidget {
  final UserData userData;

  const UserDetailsForm({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          name: 'city',
          initialValue: userData.city,
          decoration: InputDecoration(
              labelText: 'City',
              helperText:
                  'This detail is used to fetch the current weather info in your area.',
              helperMaxLines: 3),
        ),
        SizedBox(
          height: 10,
        ),
        FormBuilderTextField(
          name: 'name',
          initialValue: userData.name,
          decoration: InputDecoration(
              labelText: 'Name',
              helperText: "We would like to know you better! What's your name?",
              helperMaxLines: 1),
        ),
      ],
    );
  }
}
